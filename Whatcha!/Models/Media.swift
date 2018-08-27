//
//  Media.swift
//  Whatcha!
//
//  Created by Leonardo Garcia  on 8/27/18.
//  Copyright © 2018 Leonardo Garcia. All rights reserved.
//

import Foundation

struct Media: Codable {
    let id: Int
    let title: Title
    let type: String
    let status: String
    let format: String
    let startDate: DateReference
    let genres: [String]
    let averageScore: Int
    let episodes: Int
    let coverImage: CoverImageLink
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case type
        case status
        case format
        case startDate
        case genres
        case averageScore
        case episodes
        case coverImage
    }
}

struct Title: Codable {
    let english: String?
    let native: String?
    
    enum CodingKeys: String, CodingKey {
        case english
        case native
    }
}

struct CoverImageLink: Codable {
    let large: String
    let medium: String
    
    enum CodingKeys: String, CodingKey {
        case large
        case medium
    }
}
