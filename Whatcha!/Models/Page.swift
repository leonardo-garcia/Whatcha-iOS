//
//  Page.swift
//  Whatcha!
//
//  Created by Leonardo Garcia  on 8/27/18.
//  Copyright © 2018 Leonardo Garcia. All rights reserved.
//

import Foundation

/// Model used to store and decode a Page according to the API reference
struct Page: Codable {
    let pageInfo: PageInfo
    let media: [Media]
}
