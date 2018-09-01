//
//  ImageManager.swift
//  Whatcha!
//
//  Created by Leonardo Garcia  on 8/31/18.
//  Copyright © 2018 Leonardo Garcia. All rights reserved.
//

import UIKit
import Foundation

/// Identity in charge of manipulating resource images
class ImageManager {
    
    private var cachedImages = [String: UIImage]()
    
    /// Checks if there is an image registered with the url sent.
    /// If there isn't, it attemts to get the image from internet.
    ///
    /// - Parameters:
    ///   - url: Internet URL that contains the image
    ///   - completion: Action to be done when the image is fetched
    func getCachedImage(for url: String, completion: @escaping (UIImage?) -> Void) {
        if let image = cachedImages[url] {
            completion(image)
            return
        } else {
            Network.fetch(type: Data.self, url: url, httpMethod: .get) { [weak self] result in
                switch result {
                case .object(let data):
                    if let weakSelf = self {
                        if let image = UIImage(data: data) {
                            weakSelf.cachedImages[url] = image
                        }
                        if let imageCached = weakSelf.cachedImages[url] {
                            completion(imageCached)
                            return
                        }
                        completion(nil)
                        return
                    }
                case .fail(let error):
                    print(error)
                    completion(nil)
                    return
                }
            }
        }
    }
    
}
