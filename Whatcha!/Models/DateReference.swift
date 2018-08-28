//
//  DateReference.swift
//  Whatcha!
//
//  Created by Leonardo Garcia  on 8/27/18.
//  Copyright © 2018 Leonardo Garcia. All rights reserved.
//

import Foundation

/// Model used for storing Date according API reference
struct DateReference: Codable {
    let year: Int?
    let month: Int?
    let day: Int?
}
