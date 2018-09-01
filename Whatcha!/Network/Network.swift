//
//  Network.swift
//  Whatcha!
//
//  Created by Leonardo Garcia  on 8/23/18.
//  Copyright © 2018 Leonardo Garcia. All rights reserved.
//

import Foundation
import UIKit

typealias Json = [String: Any]

class Network {

    /// Generic function designed to retrieve and parse data/object from any URL (or default AniListAPI)
    ///
    /// - Parameters:
    ///   - type: Type of the model object to be retrieved by the function
    ///   - url: String of the resource location
    ///   - httpMethod: method to be used by the network request (default: .post)
    ///   - settings: Configuration required from the API to gather information
    ///   - completion: Function that may receive the parsed object
    static func fetch<G: Decodable>(type: G.Type,
                                    url: String? = nil,
                                    httpMethod: HTTPMethod = .post,
                                    settings: [String: Any]? = nil,
                                    completion: @escaping (_ result: Result<G>) -> Void) {
       
        let urlString = url ?? .aniListUrl
        
        guard let urlObject = URL(string: urlString) else { completion(Result.fail(NetworkError.badURL)); return }
        var urlRequest = URLRequest(url: urlObject)
        
        if let settings = settings {
            do {
                let body = try JSONSerialization.data(withJSONObject: settings, options: .prettyPrinted)
                urlRequest.httpBody = body
            } catch {
                completion(Result.fail(NetworkError.wrongBodyFormat))
                return
            }
        }
        
        urlRequest.httpMethod = httpMethod.rawValue
        urlRequest.setValue(.contentJson, forHTTPHeaderField: HeaderField.accept.rawValue)
        urlRequest.setValue(.contentJson, forHTTPHeaderField: HeaderField.contentType.rawValue)
        
        let task = URLSession.shared.dataTask(with: urlRequest) { data, _, error in
            if let error = error {
                completion(Result.fail(error))
                return
            }
            
            guard let data = data else { completion(Result.fail(NetworkError.noDataFound)); return }
            
            if type == Data.self {
                guard let modelObject = data as? G else { completion(Result.fail(NetworkError.failedParsing)); return }
                completion(Result.object(modelObject))
                return
            }
            
            if let modelObject = try? JSONDecoder().decode(G.self, from: data) {
                completion(Result.object(modelObject))
                return
            } else {
                completion(Result.fail(NetworkError.failedParsing))
                return
            }
            
        }
        task.resume()
    }
}
