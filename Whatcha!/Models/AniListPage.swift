//
//  AnilistPage.swift
//  Whatcha!
//
//  Created by Leonardo Garcia  on 8/27/18.
//  Copyright © 2018 Leonardo Garcia. All rights reserved.
//

import Foundation

struct AniListPage: Codable {
    let data: PageResource
}

struct PageResource: Codable {
    let page: Page
    
    enum CodingKeys: String, CodingKey {
        case page = "Page"
    }
}
