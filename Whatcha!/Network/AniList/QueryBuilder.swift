//
//  QueryBuilder.swift
//  Whatcha!
//
//  Created by Leonardo Garcia  on 8/27/18.
//  Copyright © 2018 Leonardo Garcia. All rights reserved.
//

import Foundation

class QueryBuilder {
    static func anime(id: Int) -> Json {
        let query = """
            query ($id: Int) {
              Media (id: $id, type: ANIME) { 
                id
                type
                status
                format
                coverImage {
                  large
                  medium
                }
                bannerImage
                startDate {
                  year
                  month
                  day
                }
                episodes
                genres
                averageScore
                title {
                  english
                  romaji
                }
              }
            }
        """
        let variables = ["id": id]
        return ["query": query, "variables": variables]
    }
    
    static func page(number: Int, perPage: Int, type: MediaType, genre: Genre, sort: MediaSort) -> Json {
        let query = """
            query ($page: Int, $perPage: Int, $type: MediaType, $genre: String $sort: [MediaSort]) {
                Page(page: $page, perPage: $perPage) {
                    pageInfo {
                      total
                      perPage
                      currentPage
                      lastPage
                      hasNextPage
                    }
                    media(type: $type genre: $genre sort: $sort) {
                      id
                      type
                      status
                      format
                      coverImage {
                        large
                        medium
                      }
                      bannerImage
                      startDate {
                        year
                        month
                        day
                      }
                      episodes
                      genres
                      averageScore
                      title {
                        english
                        romaji
                      }
                    }
                  }
            }
        """
        let variables: Json = [
            "page": number,
            "perPage": perPage,
            "type": type.rawValue,
            "genre": genre.rawValue,
            "sort": sort.rawValue
            ]
        return ["query": query, "variables": variables]
    }
}
