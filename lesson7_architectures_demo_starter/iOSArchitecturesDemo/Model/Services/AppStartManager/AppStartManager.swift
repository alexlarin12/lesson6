//
//  AppStartConfigurator.swift
//  iOSArchitecturesDemo
//
//  Created by ekireev on 19.02.2018.
//  Copyright © 2018 ekireev. All rights reserved.
//

import UIKit
/*
final class AppStartManager {
    
    var window: UIWindow?
    
    init(window: UIWindow?) {
        self.window = window
    }
    
    func start() {
       
        let rootVC = SearchModuleBuilder.build()
        rootVC.navigationItem.title = "Search via iTunes"
        
        let navVC = self.configuredNavigationController
        navVC.viewControllers = [rootVC]
        
        window?.rootViewController = navVC
        window?.makeKeyAndVisible()
    }
    
    private lazy var configuredNavigationController: UINavigationController = {
        let navVC = UINavigationController()
        navVC.navigationBar.barTintColor = UIColor.varna
        navVC.navigationBar.isTranslucent = false
        navVC.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navVC.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        return navVC
    }()
}
*/
final class AppStartManager {
    
    var window: UIWindow?
    
    init(window: UIWindow?) {
        self.window = window
    }
    
    func start() {
        let tabBarController = UITabBarController()
        
        let rootVC = SearchModuleBuilder.build()
        rootVC.navigationItem.title = "Search via iTunes"
        let songsVC = SearchSongsModuleBuilder.build()
        songsVC.navigationItem.title = "Search via Songs"
        
        
        let firstNavVC = self.configuredNavigationController
        firstNavVC.viewControllers = [rootVC]
        let secondNavVC = self.configuredSecondNavigationController
        secondNavVC.viewControllers = [songsVC]
  
        tabBarController.viewControllers = [firstNavVC, secondNavVC]

        let item1 = UITabBarItem(title: "Apps", image: UIImage(named: ""), tag: 0)
        let item2 = UITabBarItem(title: "Music", image: UIImage(named: ""), tag: 1)

        firstNavVC.tabBarItem = item1
        secondNavVC.tabBarItem = item2
        
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
    }
    
    private lazy var configuredNavigationController: UINavigationController = {
        let navVC = UINavigationController()
        navVC.navigationBar.barTintColor = UIColor.varna
        navVC.navigationBar.isTranslucent = false
        navVC.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navVC.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        return navVC
    }()
    
    private lazy var configuredSecondNavigationController: UINavigationController = {
        let navVC = UINavigationController()
        navVC.navigationBar.barTintColor = UIColor.varna
        navVC.navigationBar.isTranslucent = false
        navVC.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navVC.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        return navVC
    }()
}
