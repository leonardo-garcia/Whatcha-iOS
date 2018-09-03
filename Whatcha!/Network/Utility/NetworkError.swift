//
//  NetworkError.swift
//  Whatcha!
//
//  Created by Leonardo Garcia  on 8/31/18.
//  Copyright © 2018 Leonardo Garcia. All rights reserved.
//

import Foundation

/// Enum used to specify a problem found when making a request
enum NetworkError: Error {
    case badURL
    case wrongBodyFormat
    case unableToFetchRequest
    case noDataFound
    case failedParsing
}

extension NetworkError: LocalizedError {
    var depiction: String {
        switch self {
        case .badURL:
            return "Bad URL on request"
        case .wrongBodyFormat:
            return "Wrong request's HTTP-body-format."
        case .unableToFetchRequest:
            return "Unable to make request."
        case .noDataFound:
            return "No data was received."
        case .failedParsing:
            return "Could not parse object based on request response."
        }
    }
}
