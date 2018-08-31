//
//  HomeViewController.swift
//  Whatcha!
//
//  Created by Leonardo Garcia  on 8/22/18.
//  Copyright © 2018 Leonardo Garcia. All rights reserved.
//

import UIKit

class HomeTableViewController: UITableViewController {
    
    var homeData = HomeData()
    lazy var loadingView: UIView = {
        let view = UIView(frame: self.view.bounds)
        view.backgroundColor = .black
        return view
    }()
    
    let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
    
    let dispatchGroup = DispatchGroup()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Home"
        
        tableView.tableHeaderView = loadingView
        activityIndicator.startAnimating()
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        loadingView.addSubview(activityIndicator)
        let contraints = [
            activityIndicator.centerXAnchor.constraint(equalTo: loadingView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: loadingView.centerYAnchor)
        ]
        NSLayoutConstraint.activate(contraints)
        
        self.tableView.rowHeight = 190
        self.tableView.register(HomeTableViewCell.self, forCellReuseIdentifier: .tableCellIdentifier)
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        for genre in homeData.genres {
            
            dispatchGroup.enter()
            Network.fetch(type: AniListPage.self,
                          settings: QueryBuilder.page(number: 1,
                                                      perPage: 20,
                                                      type: .anime,
                                                      genre: genre,
                                                      sort: .popularityDescendent)) { [weak self] anipage in
                if let anipage = anipage, let media = anipage.data?.page.media {
                    print("fetched info of \(genre)")
                    if let weakSelf = self {
                        
                        weakSelf.homeData.mediaElements[genre.rawValue] = media
                        weakSelf.dispatchGroup.leave()
                        
                    } else {
                        fatalError("A reference to self is needed to fill Home data")
                    }
                }
            }
        }
        
        dispatchGroup.notify(queue: .main) {
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            self.activityIndicator.stopAnimating()
            self.tableView.tableHeaderView = nil
            self.tableView.reloadData()
        }
    }

}

// MARK: - TableView Delegate and DataSource method implementation
extension HomeTableViewController {
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let tableCell = tableView.dequeueReusableCell(withIdentifier: .tableCellIdentifier, for: indexPath)
            as? HomeTableViewCell else { return UITableViewCell() }
        tableCell.collectionView.dataSource = self
        tableCell.collectionView.delegate = self
        tableCell.collectionView.register(HomeCollectionViewCell.self, forCellWithReuseIdentifier: .collectionCellIdentifier)
        tableCell.collectionView.tag = indexPath.section
        tableCell.collectionView.reloadData()
        return tableCell
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return homeData.genres.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return homeData.genres[section].rawValue
    }

}

// MARK: - CollectionViews Delegate and DataSource method implementation
extension HomeTableViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let elementsInSection = homeData.mediaElements[homeData.genres[collectionView.tag].rawValue]?.count else {
            return 0
        }
        return elementsInSection
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell: HomeCollectionViewCell =
                collectionView.dequeueReusableCell(withReuseIdentifier: .collectionCellIdentifier, for: indexPath)
                as? HomeCollectionViewCell else { return UICollectionViewCell() }
        if let media = homeData.mediaElements[homeData.genres[collectionView.tag].rawValue]?[indexPath.row] {
            cell.setupCell(with: media)
        }
        return cell
    }
    
}

extension String {
    static let tableCellIdentifier = "TableCellIdentifier"
    static let collectionCellIdentifier = "CollectionCellIdentifier"
}
