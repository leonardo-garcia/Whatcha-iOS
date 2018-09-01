//
//  Media.swift
//  Whatcha!
//
//  Created by Leonardo Garcia  on 8/27/18.
//  Copyright © 2018 Leonardo Garcia. All rights reserved.
//

import UIKit

/// Model used to store media information of an specific Anime/Manga
class Media: Codable {
    let id: Int
    let title: Title
    let type: String
    let status: String
    let format: String
    let startDate: DateReference
    let genres: [String]
    let averageScore: Int?
    let episodes: Int?
    let coverImageLink: CoverImageLink
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
        case coverImageLink = "coverImage"
        case bannerImageLink = "bannerImage"
    }
    
    init() {
        id = 0
        title = Title(english: nil, romaji: nil)
        type = ""
        status = ""
        format = ""
        startDate = DateReference(year: nil, month: nil, day: nil)
        genres = []
        averageScore = nil
        episodes = nil
        coverImageLink = CoverImageLink(large: "", medium: "")
        bannerImageLink = nil
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
