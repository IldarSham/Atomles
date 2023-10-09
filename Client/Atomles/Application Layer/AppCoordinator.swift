//
//  AppCoordinator.swift
//  Atomles
//
//  Created by Ildar on 09.06.2022.
//

import UIKit

class AppCoordinator: Coordinator {
    
    let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
        
    func start() {
        let navigationController = UINavigationController()
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        window.overrideUserInterfaceStyle = AppThemeStorageService.shared.getCurrentTheme().getUserInterfaceStyle()
                
        let tabBarCoordinator = TabBarCoordinator(navigationController: navigationController)
        coordinate(to: tabBarCoordinator)
    }
}
