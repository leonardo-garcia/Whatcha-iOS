//
//  HomeViewController.swift
//  Whatcha!
//
//  Created by Leonardo Garcia  on 8/22/18.
//  Copyright © 2018 Leonardo Garcia. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func loadView() {
        let customView = HomeView(frame: .zero)
        view = customView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Home"
        
        let query = """
            query ($id: Int) {
              Media (id: $id, type: ANIME) { # Insert our variables into the query arguments (id) (type: ANIME is hard-coded in the query)
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
                  native
                }
              }
            }
        """
        let variables = ["id": "1"]
        let settings: [String: Any] = ["query": query, "variables": variables]
        Network.fetch(g: Resource.self, settings: settings) { resource in
            if let resource = resource {
                print(resource)
            } 
        }
    }
}
