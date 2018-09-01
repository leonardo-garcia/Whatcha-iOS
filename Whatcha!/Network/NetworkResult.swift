//
//  NetworkResult.swift
//  Whatcha!
//
//  Created by Leonardo Garcia  on 8/31/18.
//  Copyright © 2018 Leonardo Garcia. All rights reserved.
//

import Foundation

/// Enum used to determine a operation status outcome
enum Result<T> {
    case object(T)
    case fail(Error)
}
