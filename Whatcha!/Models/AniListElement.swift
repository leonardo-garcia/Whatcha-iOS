//
//  Anime.swift
//  Whatcha!
//
//  Created by Leonardo Garcia  on 8/27/18.
//  Copyright © 2018 Leonardo Garcia. All rights reserved.
//

import Foundation

/// Main model for retrieving unspecific elements from API
struct AniListElement: Codable {
    let data: MediaInfo?
    let errors: [DataError]?
}

/// Content of resource according API reference
struct MediaInfo: Codable {
    let media: Media?
    
    enum CodingKeys: String, CodingKey {
        case media = "Media"
    }
}
