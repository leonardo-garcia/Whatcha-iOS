//
//  HomeData.swift
//  Whatcha!
//
//  Created by Leonardo Garcia  on 8/29/18.
//  Copyright © 2018 Leonardo Garcia. All rights reserved.
//

import Foundation

struct HomeData {
    let genres: [Genre]
    var mediaElements: [String: [Media]]
    
    init() {
        genres = [
            .action,
            .adventure,
            .comedy,
            .drama,
            .horror,
            .music
        ]
        
        mediaElements = [String: [Media]]()
        initMedia()
    }
    
    mutating private func initMedia() {
        for genre in genres {
            mediaElements[genre.rawValue] = [Media]()
        }
    }
}
