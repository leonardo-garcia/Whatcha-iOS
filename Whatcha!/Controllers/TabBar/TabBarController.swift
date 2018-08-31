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
        
        tabBar.barTintColor = .black
        
        let homeViewController = HomeTableViewController()
        homeViewController.tabBarItem = UITabBarItem(title: "Home", image: #imageLiteral(resourceName: "HomeIcon"), tag: 1)
        let viewControllerList = [homeViewController]
        viewControllers = viewControllerList.map {
            
            let navigationController = UINavigationController(rootViewController: $0)
            navigationController.navigationBar.barStyle = .blackTranslucent

            navigationController.navigationBar.barTintColor = .black
            return navigationController
            
        }
        
    }
}
