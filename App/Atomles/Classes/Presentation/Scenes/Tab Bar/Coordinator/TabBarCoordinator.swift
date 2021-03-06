//
//  TabBarCoordinator.swift
//  Atomles
//
//  Created by Ildar on 07.02.2022.
//

import UIKit

class TabBarCoordinator: Coordinator {
    
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let tabBarController = TabBarController()
        
        let seriesListNavigationController = UINavigationController()
        seriesListNavigationController.tabBarItem = UITabBarItem(
            title: "Серии", image: UIImage(systemName: "play.circle"), tag: 1)
        let seriesListCoordinator = SeriesListCoordinator(navigationController: seriesListNavigationController)
        
        let searchNavigationController = UINavigationController()
        searchNavigationController.tabBarItem = UITabBarItem(
            title: "Поиск", image: UIImage(systemName: "magnifyingglass"), tag: 2)
        let searchCoordinator = SearchCoordinator(navigationController: searchNavigationController)
        
        tabBarController.viewControllers = [seriesListNavigationController, searchNavigationController]
        
        navigationController.viewControllers = [tabBarController]
        
        coordinate(to: seriesListCoordinator)
        coordinate(to: searchCoordinator)
    }
}
