//
//  MainTabViewController.swift
//  olchatask
//
//  Created by Iskandarov shaxzod on 10.10.2023.
//

import UIKit

class MainTabBarController: UITabBarController {
    override func viewDidLoad() {
        
        let postsVC = PostsViewController()
        postsVC.tabBarItem.title = "Posts"
        postsVC.tabBarItem.image = UIImage(systemName: "bubble.middle.top")
        
        let savedVC = SavedPostsViewController()
        savedVC.tabBarItem.title = "Saved"
        savedVC.tabBarItem.image = UIImage(systemName: "square.and.arrow.down")
        
        self.setViewControllers([postsVC, savedVC], animated: false)
        
        tabBar.backgroundColor = .lightGray
    }
}
