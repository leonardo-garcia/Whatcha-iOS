//
//  HomeHeaderSectionView.swift
//  Whatcha!
//
//  Created by Leonardo Garcia  on 9/3/18.
//  Copyright © 2018 Leonardo Garcia. All rights reserved.
//

import UIKit

class HomeHeaderSectionView: UIView {
    
    /// Title of section
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 40)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .defaultFontColor
        return label
    }()
    
    // MARK: - Initializers
    init() {
        super.init(frame: .zero)
        backgroundColor = .defaultColor
        alpha = 0.9
        addSubview(titleLabel)
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Setup
    private func setupConstraints() {
        let titleContraints = [
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
        ]
        NSLayoutConstraint.activate(titleContraints)
    }
    
    func setTitle(with text: String) {
        titleLabel.text = text
    }
    
}
