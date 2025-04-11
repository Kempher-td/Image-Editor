//
//  TabBarController.swift
//  Image Editor
//
//  Created by Victor Mashukevich on 25.03.24.
//

import Foundation
import UIKit
final class TabbarController: UITabBarController {
    
    enum Tabs: Int {
        case main
        case settings
    }
    
    
    init() {
            super.init(nibName: nil, bundle: nil)
            configure()
        }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   
    private func configure() {
        
        tabBar.tintColor = .black
        tabBar.backgroundColor = .systemTeal
        tabBar.layer.borderWidth = 1
        tabBar.layer.masksToBounds = true
        
        let mainController = MainController()
        let settingsController = SettingsController()
        
        let mainNavigation = NavbarController(rootViewController: mainController)
        let settingsNavigation = NavbarController(rootViewController: settingsController)
        
        mainNavigation.tabBarItem = UITabBarItem(title: "Main",
                                                 image: UIImage(systemName: "house.fill"),
                                                 tag: Tabs.main.rawValue)
        
        settingsNavigation.tabBarItem = UITabBarItem(title: "Settings",
                                                     image: UIImage(systemName: "gear"),
                                                     tag: Tabs.settings.rawValue)
        
        setViewControllers([
        mainNavigation,
        settingsNavigation
        ], animated: false)
    }
}
