//
//  DateReference.swift
//  Whatcha!
//
//  Created by Leonardo Garcia  on 8/27/18.
//  Copyright © 2018 Leonardo Garcia. All rights reserved.
//

import Foundation

struct DateReference: Codable {
    let year: Int
    let month: Int
    let day: Int
    
    enum CodingKeys: String, CodingKey {
        case year
        case month
        case day
    }
}
