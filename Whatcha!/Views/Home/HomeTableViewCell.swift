//
//  HomeTableViewCell.swift
//  Whatcha!
//
//  Created by Leonardo Garcia  on 8/28/18.
//  Copyright © 2018 Leonardo Garcia. All rights reserved.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    
    var collectionView: UICollectionView!
    
    // MARK: - Initializers
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupContraints()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Views' Setup
    func setupViews() {
        backgroundColor = .defaultColor
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 110.0, height: 180.0)
        layout.minimumLineSpacing = 10
        
        collectionView = UICollectionView(frame: self.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = .defaultColor
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(HomeCollectionViewCell.self, forCellWithReuseIdentifier: .collectionCellIdentifier)
        
        self.addSubview(collectionView)
    }
    
    func setupContraints() {
        let constraints = [
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
