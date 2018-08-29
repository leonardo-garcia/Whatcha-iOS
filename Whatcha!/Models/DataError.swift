//
//  DataError.swift
//  Whatcha!
//
//  Created by Leonardo Garcia  on 8/29/18.
//  Copyright © 2018 Leonardo Garcia. All rights reserved.
//

import Foundation

/// Error structure specified on API reference
struct DataError: Codable {
    let message: String
    let status: Int
}
