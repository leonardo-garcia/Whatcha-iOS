//
//  Media.swift
//  Whatcha!
//
//  Created by Leonardo Garcia  on 8/27/18.
//  Copyright © 2018 Leonardo Garcia. All rights reserved.
//

import Foundation

/// Model used to store media information of an specific Anime/Manga
struct Media: Codable {
    let id: Int
    let title: Title
    let type: String
    let status: String
    let format: String
    let startDate: DateReference
    let genres: [String]
    let averageScore: Int?
    let episodes: Int?
    let coverImage: CoverImageLink
    let bannerImageLink: String?
    
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
        case bannerImageLink = "bannerImage"
    }
}

/// Title of a specific element
struct Title: Codable {
    let english: String?
    let romaji: String?
}

struct CoverImageLink: Codable {
    let large: String
    let medium: String
}
