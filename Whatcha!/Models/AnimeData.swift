//
//  HomeData.swift
//  Whatcha!
//
//  Created by Leonardo Garcia  on 8/29/18.
//  Copyright © 2018 Leonardo Garcia. All rights reserved.
//

import Foundation

/// Model used to handle necesary data on Home's CollectionViews and TableView
struct AnimeData {
    var genres: [Genre]
    var mediaElements: [String: [Media]]
    
    init() {
        genres = []
        mediaElements = [String: [Media]]()
    }
}
