//
//  Anime.swift
//  Whatcha!
//
//  Created by Leonardo Garcia  on 8/27/18.
//  Copyright © 2018 Leonardo Garcia. All rights reserved.
//

import Foundation

struct Resource: Codable {
    let data: MediaInfo
    
    enum CodingKeys: String, CodingKey {
        case data
    }
}

struct MediaInfo: Codable {
    let media: Media
    
    enum CodingKeys: String, CodingKey {
        case media = "Media"
    }
}
