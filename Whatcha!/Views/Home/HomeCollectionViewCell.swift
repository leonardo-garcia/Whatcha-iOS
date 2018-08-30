//
//  HomeCollectionViewCell.swift
//  Whatcha!
//
//  Created by Leonardo Garcia  on 8/28/18.
//  Copyright © 2018 Leonardo Garcia. All rights reserved.
//

import UIKit

class HomeCollectionViewCell: UICollectionViewCell {
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "Empty")
        imageView.contentMode = .scaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Title"
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
        setupContrains()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupContrains() {
        let contraints = [
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -22),
            imageView.leftAnchor.constraint(equalTo: leftAnchor),
            imageView.rightAnchor.constraint(equalTo: rightAnchor),
            titleLabel.topAnchor.constraint(equalTo: bottomAnchor, constant: -22),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            titleLabel.leftAnchor.constraint(equalTo: leftAnchor),
            titleLabel.rightAnchor.constraint(equalTo: rightAnchor)
            
        ]
        NSLayoutConstraint.activate(contraints)
    }
    
    func setupCell(with media: Media) {
        if let englishTitle = media.title.english {
            titleLabel.text = englishTitle
        } else if let romajiTitle = media.title.romaji {
            titleLabel.text = romajiTitle
        } else {
            titleLabel.text = " - "
        }
        
        let imageUrl = media.coverImageLink.medium
        
        Network.fetch(type: Data.self, url: imageUrl, httpMethod: .get, settings: [:]) { [weak self] (data) in
            if let data = data, let image = UIImage(data: data) {
                media.coverImage = image
                DispatchQueue.main.async {
                    self?.imageView.image = image
                }
            }
        }
    }
}
