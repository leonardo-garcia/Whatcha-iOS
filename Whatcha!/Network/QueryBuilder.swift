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
    
    static func page(number: Int, perPage: Int, type: String, sort: String) -> Json {
        // TODO: Get parameters through function
        let query = """
            query ($page: Int, $perPage: Int) {
                Page(page: $page, perPage: $perPage) {
                    pageInfo {
                      total
                      perPage
                      currentPage
                      lastPage
                      hasNextPage
                    }
                    media(type: ANIME sort: [TITLE_ENGLISH]) {
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
        let variables = ["page": number, "perPage": perPage]
        return ["query": query, "variables": variables]
    }
}
