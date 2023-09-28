//
//  TabbarProvider.swift
//  BuffaloBills
//
//  Created by venkata baisani on 14/09/23.
//

import Foundation

import ESTabBarController
import UIKit

enum TabbarProvider {
    
    static func customTipsStyle(delegate: UITabBarControllerDelegate?) -> HomeViewController {
        
        
        let tabBarController = ESTabBarController()
        
        if let tabBar = tabBarController.tabBar as? ESTabBar {
            tabBar.itemCustomPositioning = .fillIncludeSeparator
        }
        
        
        tabBarController.delegate = delegate
        tabBarController.navigationController?.navigationBar.isHidden = true
//        tabBarController.title = "Irregularity"
//        tabBarController.tabBar.shadowImage = UIImage(named: "transparent")
//        tabBarController.tabBar.backgroundImage = UIImage(named: "background_dark")
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let v1 = storyboard.instantiateViewController(withIdentifier: "NewsViewController") as! NewsViewController

        let v2 = storyboard.instantiateViewController(withIdentifier: "VideosViewController") as! VideosViewController
        
        let v3 = storyboard.instantiateViewController(withIdentifier: "ScheduleViewController") as! ScheduleViewController
        
        let v4 = storyboard.instantiateViewController(withIdentifier: "StadiumViewController") as! StadiumViewController
        
        let v5 = storyboard.instantiateViewController(withIdentifier: "StoreViewController") as! StoreViewController
//        ExampleAnimateTipsContentView3

        v1.tabBarItem = ESTabBarItem.init(ExampleHighlightableContentView(), title: "Home", image: UIImage(named: "home"), selectedImage: UIImage(named: "home"))
        v2.tabBarItem = ESTabBarItem.init(ExampleHighlightableContentView(), title: "Find", image: UIImage(named: "about"), selectedImage: UIImage(named: "about"))
        v3.tabBarItem = ESTabBarItem.init(ExampleHighlightableContentView(), title: "Photo", image: UIImage(named: "acount"), selectedImage: UIImage(named: "acount"))
        v4.tabBarItem = ESTabBarItem.init(ExampleHighlightableContentView(), title: "Favor", image: UIImage(named: "notification"), selectedImage: UIImage(named: "notification"))
        v5.tabBarItem = ESTabBarItem.init(ExampleHighlightableContentView(), title: "Me", image: UIImage(named: "setting"), selectedImage: UIImage(named: "setting"))
     
        
        tabBarController.viewControllers = [v1, v2, v3, v4, v5]
        
        
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let controller = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
       
        // controller.notification = arrNotifications[currentIndex] need to add notification data
//        self.navigationController?.pushViewController(controller, animated: true)
        
        let navigationController = HomeViewController.init(rootViewController: tabBarController)
//        tabBarController.title = "Example"
//        navigationController
        navigationController.navigationBar.isHidden = true
        
        return navigationController
    }
}
