//
//  Network.swift
//  Whatcha!
//
//  Created by Leonardo Garcia  on 8/23/18.
//  Copyright © 2018 Leonardo Garcia. All rights reserved.
//

import Foundation

typealias Json = [String: Any]

class Network {
    
    /// Generic function designed to retrieve data from AnilistAPI
    ///
    /// - Parameters:
    ///   - type: Type of the model object to be retrieved by the function
    ///   - settings: Configuration required from the API to gather information
    ///   - completion: Function that may receive the parsed object
    static func fetch<G: Decodable>(type: G.Type, settings: [String: Any], completion: @escaping (G?) -> Void) {
        guard let url = URL(string: .aniListUrl) else { completion(nil); return }
        var urlRequest = URLRequest(url: url)
        
        do {
            let body = try JSONSerialization.data(withJSONObject: settings, options: .prettyPrinted)
            urlRequest.httpBody = body
        } catch {
            //TODO: Handle errors
            print("Could not set HTTP body")
            completion(nil)
            return
        }
        urlRequest.httpMethod = HTTPMethod.post.rawValue
        urlRequest.setValue(.contentJson, forHTTPHeaderField: HeaderField.accept.rawValue)
        urlRequest.setValue(.contentJson, forHTTPHeaderField: HeaderField.contentType.rawValue)
        
        let task = URLSession.shared.dataTask(with: urlRequest) { data, _, error in
            if let error = error {
                print(error)
                completion(nil)
                return
            }
            
            guard let data = data else { completion(nil); return }
          
            if let string = String(data: data, encoding: .utf8) {
                print(string)
            }
            
            if let modelObject = try? JSONDecoder().decode(G.self, from: data) {
                completion(modelObject)
                return
            } else {
                print("Could not decode Object")
                completion(nil)
                return
            }
            
        }
        task.resume()
    }
}
