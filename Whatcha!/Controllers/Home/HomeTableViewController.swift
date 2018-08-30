//
//  HomeViewController.swift
//  Whatcha!
//
//  Created by Leonardo Garcia  on 8/22/18.
//  Copyright © 2018 Leonardo Garcia. All rights reserved.
//

import UIKit

class HomeTableViewController: UITableViewController {
    
    var homeData = HomeData() {
        didSet {
            self.tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Home"
        
        self.tableView.rowHeight = 190
        self.tableView.register(HomeTableViewCell.self, forCellReuseIdentifier: .tableCellIdentifier)
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        var genreLoadedCount = 0
        for genre in homeData.genres {
            Network.fetch(type: AniListPage.self,
                          settings: QueryBuilder.page(number: 1,
                                                      perPage: 20,
                                                      type: .anime,
                                                      genre: genre,
                                                      sort: .popularityDescendent)) { [weak self] anipage in
                if let anipage = anipage, let media = anipage.data?.page.media {
                    print("fetched info of \(genre)")
                    if let weakSelf = self {
                        DispatchQueue.main.async {
                            weakSelf.homeData.mediaElements[genre.rawValue] = media
                            genreLoadedCount += 1
                            if genreLoadedCount == weakSelf.homeData.genres.count {
                                print(genre)
                                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            }
                        }
                    }
                }
            }
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
        tableCell.collectionView.reloadData()
        tableCell.collectionView.tag = indexPath.section
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
