//
//  TabBarViewController.swift
//  Places
//
//  Created by Ria Vora on 12/5/20.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let blockViewController = ViewController()
        let mapViewController = MapViewController()
        let userViewController = UserViewController()
        
        
        blockViewController.tabBarItem = UITabBarItem(title: "Block", image: nil, tag: 0)
        mapViewController.tabBarItem = UITabBarItem(title: "Map", image: nil, tag: 1)
        userViewController.tabBarItem = UITabBarItem(title: "User", image: nil, tag: 2)
       // blockViewController.tabBarItem.imageInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: -10)
      
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font : UIFont.systemFont(ofSize: 20)], for: .normal)
        self.setViewControllers([blockViewController, mapViewController, userViewController], animated: true)
        
    }
    
    override func viewDidLayoutSubviews() {
        // Reference: https://webappcodes.com/change-tabbar-height-in-swift-5-for-ios-13
        super.viewDidLayoutSubviews()
        tabBar.frame.size.height = 75
        tabBar.frame.origin.y = view.frame.height - 75
    }
    
}
