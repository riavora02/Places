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
        let favoritesViewController = FavoritesViewController()
        
        
        blockViewController.tabBarItem = UITabBarItem(title: "Tile", image: UIImage(systemName: "server.rack"), tag: 0)
        mapViewController.tabBarItem = UITabBarItem(title: "Map", image: UIImage(systemName: "map.fill"), tag: 1)
        favoritesViewController.tabBarItem = UITabBarItem(title: "Favorites", image: UIImage(systemName: "star.fill"), tag: 2)
        userViewController.tabBarItem = UITabBarItem(title: "Contribute",image: UIImage(systemName: "person.fill"), tag: 3)
       // blockViewController.tabBarItem.imageInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: -10)
      
        //UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16)], for: .normal)
        self.tabBar.isOpaque = true
        self.setViewControllers([mapViewController, blockViewController, favoritesViewController, userViewController], animated: true)
        
    }
    
    override func viewDidLayoutSubviews() {
        // Reference: https://webappcodes.com/change-tabbar-height-in-swift-5-for-ios-13
        super.viewDidLayoutSubviews()
        
    }
    
}
