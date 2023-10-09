//
//  TabBarCoordinator.swift
//  Atomles
//
//  Created by Ildar on 09.06.2022.
//

import UIKit

class TabBarCoordinator: Coordinator {
    
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        setupTabBarController()
    }
    
    private func setupTabBarController() {
        let tabBarController = TabBarController()
        tabBarController.viewControllers = [
            createSeriesListNavigationController(),
            createCharactersListNavigationController(),
            createQuotesListNavigationController(),
            createSettingsNavigationController()
        ]
        navigationController.viewControllers = [tabBarController]
    }

    private func createSeriesListNavigationController() -> UINavigationController {
        let seriesListNavigationController = UINavigationController()
        seriesListNavigationController.tabBarItem = UITabBarItem(title: "Серии", image: UIImage(systemName: "play.circle.fill"), tag: 1)
        
        let seriesListCoordinator = SeriesListCoordinator(navigationController: seriesListNavigationController)
        coordinate(to: seriesListCoordinator)
        
        return seriesListNavigationController
    }

    private func createCharactersListNavigationController() -> UINavigationController {
        let charactersListNavigationController = UINavigationController()
        charactersListNavigationController.tabBarItem = UITabBarItem(title: "Персонажи", image: UIImage(named: "bear.footprint"), tag: 2)
        
        let charactersListCoordinator = CharactersListCoordinator(navigationController: charactersListNavigationController)
        coordinate(to: charactersListCoordinator)
        
        return charactersListNavigationController
    }

    private func createQuotesListNavigationController() -> UINavigationController {
        let quotesListNavigationController = UINavigationController()
        quotesListNavigationController.tabBarItem = UITabBarItem(title: "Цитатник", image: UIImage(named: "quote"), tag: 3)
        
        let quotesListCoordinator = QuotesListCoordinator(navigationController: quotesListNavigationController)
        coordinate(to: quotesListCoordinator)
        
        return quotesListNavigationController
    }
    
    private func createSettingsNavigationController() -> UINavigationController {
        let settingsNavigationController = UINavigationController()
        settingsNavigationController.tabBarItem = UITabBarItem(title: "Настройки", image: UIImage(systemName: "gearshape.fill"), tag: 4)
        
        let settingsCoordinator = SettingsCoordinator(navigationController: settingsNavigationController)
        coordinate(to: settingsCoordinator)
        
        return settingsNavigationController
    }
}
