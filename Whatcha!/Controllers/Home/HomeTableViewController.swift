//
//  HomeViewController.swift
//  Whatcha!
//
//  Created by Leonardo Garcia  on 8/22/18.
//  Copyright © 2018 Leonardo Garcia. All rights reserved.
//

import UIKit

class HomeTableViewController: UITableViewController {
    
    // MARK: - Home Properties
    private var animeData = AnimeData()
    private var imageManager = ImageManager()
    private let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
    private let homeGenres: [Genre] = [
        .adventure,
        .comedy,
        .horror,
        .music,
        .sciFi,
        .mystery,
        .action
    ]
    
    private lazy var loadingView: UIView = {
        let view = UIView(frame: self.view.bounds)
        view.backgroundColor = .defaultColor
        return view
    }()
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Whatcha!"
        setupTableView()
        addSpinner()
        downloadAnimeData()
    }
    
    // MARK: - Helper Functions
    private func setupTableView() {
        tableView.backgroundColor = .defaultColor
        tableView.separatorColor = .defaultColor
        tableView.tableHeaderView = loadingView
        tableView.rowHeight = 190
        tableView.register(HomeTableViewCell.self, forCellReuseIdentifier: .tableCellIdentifier)
    }
    
    /// Switch on activity indicator within loadingView
    private func addSpinner() {
        activityIndicator.startAnimating()
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        loadingView.addSubview(activityIndicator)
        let contraints = [
            activityIndicator.centerXAnchor.constraint(equalTo: loadingView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: loadingView.centerYAnchor)
        ]
        NSLayoutConstraint.activate(contraints)
    }
    
    /// Uses Network layer to download data from AnilistAPI
    private func downloadAnimeData() {
        let dispatchGroup = DispatchGroup()
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        for genre in homeGenres {
            dispatchGroup.enter()
            Network.fetch(type: AniListPage.self,
                          settings: QueryBuilder.page(number: 1,
                                                      perPage: 20,
                                                      type: .anime,
                                                      genre: genre,
                                                      sort: .popularityDescendent)) { [weak self] result in
                if let weakSelf = self {
                    switch result {
                    case .object(let anipage):
                        if let media = anipage.data?.page.media {
                            weakSelf.animeData.genres.append(genre)
                            weakSelf.animeData.mediaElements[genre.rawValue] = media
                            dispatchGroup.leave()
                        }
                    case .fail(let error):
                        let alert = UIAlertController(title: "Error", message: "\(error)", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                        weakSelf.present(alert, animated: true, completion: nil)
                        dispatchGroup.leave()
                    }
                } else {
                    fatalError("A reference to self is needed to fill Home data")
                }
            }
        }
        
        dispatchGroup.notify(queue: .main) { [unowned self] in
            self.finishedDownloading()
        }
    }
    
    /// Switches off animations and reloads tableView
    private func finishedDownloading() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        activityIndicator.stopAnimating()
        tableView.tableHeaderView = nil
        animeData.genres.sort(by: { $0.rawValue < $1.rawValue })
        tableView.reloadData()
    }

}

// MARK: - TableView Delegate and DataSource method implementation
extension HomeTableViewController {
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let tableCell = tableView.dequeueReusableCell(withIdentifier: .tableCellIdentifier, for: indexPath)
            as? HomeTableViewCell else { return UITableViewCell() }
        tableCell.collectionView.dataSource = self
        tableCell.collectionView.delegate = self
        tableCell.collectionView.tag = indexPath.section
        let topOffest = CGPoint(x: 0, y: -tableCell.collectionView.contentInset.top)
        tableCell.collectionView?.setContentOffset(topOffest, animated: false)
        tableCell.collectionView.reloadData()
        return tableCell
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return animeData.genres.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = HomeHeaderSectionView()
        headerView.setTitle(with: animeData.genres[section].rawValue)
        return headerView
        
    }

}

// MARK: - CollectionViews Delegate and DataSource method implementation
extension HomeTableViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let elementsInSection = animeData.mediaElements[animeData.genres[collectionView.tag].rawValue]?.count else {
            return 0
        }
        return elementsInSection
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell: HomeCollectionViewCell =
                collectionView.dequeueReusableCell(withReuseIdentifier: .collectionCellIdentifier, for: indexPath)
                as? HomeCollectionViewCell else { return UICollectionViewCell() }
        cell.coverImage = #imageLiteral(resourceName: "Empty")
        if let media = animeData.mediaElements[animeData.genres[collectionView.tag].rawValue]?[indexPath.row] {
            cell.setupCell(with: media, imageManager: imageManager)
        }
        return cell
    }
    
}

extension String {
    static let tableCellIdentifier = "TableCellIdentifier"
    static let collectionCellIdentifier = "CollectionCellIdentifier"
    static let headerSectionIdentifier = "TableViewHeaderSectionIdentifier"
}
