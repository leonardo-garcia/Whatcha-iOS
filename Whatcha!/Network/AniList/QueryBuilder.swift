//
//  QueryBuilder.swift
//  Whatcha!
//
//  Created by Leonardo Garcia  on 8/27/18.
//  Copyright © 2018 Leonardo Garcia. All rights reserved.
//

import Foundation

class QueryBuilder {
    
    /// Builds a query ready to use to retrieve an Anime element info
    ///
    /// - Parameter id: Identifier of the desired anime
    /// - Returns: [String: Any] Object that contains API specified structure
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
    
    /// Builds a query ready to use to retrieve the list of anime elements
    /// designated by the parameters specified
    ///
    /// - Parameters:
    ///   - number: Page number
    ///   - perPage: Number of elements per page
    ///   - type: Type of the elements to be retrieved
    ///   - genre: Genre of the content retrieved
    ///   - sort: Options to sort the required elements
    /// - Returns: [String: Any] Object that contains API specified structure
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
