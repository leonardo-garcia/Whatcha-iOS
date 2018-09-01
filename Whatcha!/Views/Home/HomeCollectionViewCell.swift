//
//  HomeCollectionViewCell.swift
//  Whatcha!
//
//  Created by Leonardo Garcia  on 8/28/18.
//  Copyright © 2018 Leonardo Garcia. All rights reserved.
//

import UIKit

class HomeCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Custom CollectionView Properties
    var media = Media() {
        didSet {
            if let englishTitle = media.title.english {
                titleLabel.text = englishTitle
            } else if let romajiTitle = media.title.romaji {
                titleLabel.text = romajiTitle
            } else {
                titleLabel.text = " - "
            }
        }
    }
    
    var coverImage: UIImage? {
        didSet {
            if let image = coverImage {
                DispatchQueue.main.async {
                    self.imageView.image = image
                }
            }
        }
    }
    
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
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
        setupContrains()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Views' Setup
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
    
    func setupCell(with media: Media, imageManager: ImageManager) {
        
        self.media = media
        let imageUrl = media.coverImageLink.medium
        
        imageManager.getCachedImage(for: imageUrl) { [weak self] image in
            if let image = image {
                self?.coverImage = image
            } else {
                self?.coverImage = #imageLiteral(resourceName: "Empty")
            }
        }
    }
}
