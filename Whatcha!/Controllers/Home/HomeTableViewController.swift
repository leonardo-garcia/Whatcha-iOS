//
//  HomeViewController.swift
//  Whatcha!
//
//  Created by Leonardo Garcia  on 8/22/18.
//  Copyright © 2018 Leonardo Garcia. All rights reserved.
//

import UIKit

class HomeTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Home"
        self.tableView.rowHeight = 175
        self.tableView.register(HomeTableViewCell.self, forCellReuseIdentifier: .tableCellIdentifier)
    }
}

extension HomeTableViewController {
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let tableCell = tableView.dequeueReusableCell(withIdentifier: .tableCellIdentifier, for: indexPath)
            as? HomeTableViewCell else { return UITableViewCell() }
        tableCell.collectionView.dataSource = self
        tableCell.collectionView.delegate = self
        tableCell.collectionView.register(HomeCollectionViewCell.self, forCellWithReuseIdentifier: .collectionCellIdentifier)
        return tableCell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}

extension HomeTableViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell: HomeCollectionViewCell =
                collectionView.dequeueReusableCell(withReuseIdentifier: .collectionCellIdentifier, for: indexPath)
                as? HomeCollectionViewCell else { return UICollectionViewCell() }
        if indexPath.row % 2 == 0 {
            cell.backgroundColor = .red
        } else {
            cell.backgroundColor = .yellow
        }
        return cell
    }
}

extension String {
    static let tableCellIdentifier = "TableCellIdentifier"
    static let collectionCellIdentifier = "CollectionCellIdentifier"
}
