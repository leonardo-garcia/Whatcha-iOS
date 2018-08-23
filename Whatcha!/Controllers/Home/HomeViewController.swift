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
    }
}
