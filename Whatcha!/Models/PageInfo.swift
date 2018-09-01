//
//  PageInfo.swift
//  Whatcha!
//
//  Created by Leonardo Garcia  on 8/27/18.
//  Copyright © 2018 Leonardo Garcia. All rights reserved.
//

import Foundation

/// Model that contains important info of Page object brough by the API reference
struct PageInfo: Codable {
    let currentPage: Int
    let lastPage: Int
    let hasNextPage: Bool
}
