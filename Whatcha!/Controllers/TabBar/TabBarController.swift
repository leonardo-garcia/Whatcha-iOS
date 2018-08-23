//
//  TabBarViewController.swift
//  Whatcha!
//
//  Created by Leonardo Garcia  on 8/23/18.
//  Copyright © 2018 Leonardo Garcia. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let homeViewController = HomeViewController()
        homeViewController.tabBarItem = UITabBarItem(title: "Home", image: #imageLiteral(resourceName: "HomeIcon"), tag: 1)
        let viewControllerList = [homeViewController]
        viewControllers = viewControllerList.map { UINavigationController(rootViewController: $0) }
        
    }
}
