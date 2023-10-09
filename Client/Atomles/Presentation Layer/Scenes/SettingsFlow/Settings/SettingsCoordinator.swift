//
//  SettingsCoordinator.swift
//  Atomles
//
//  Created by Ildar Shamsullin on 13.02.2023.
//

import UIKit

protocol SettingsCoordinatorProtocol {
    func pushToSettingsOptions(with model: SettingsOptionsModel, delegate: SettingsOptionsCoordinatorDelegate)
}

class SettingsCoordinator: Coordinator {
    
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let settingsViewController = SettingsViewController()
        let settingsPresenter = SettingsPresenter(
            view: settingsViewController,
            appThemeStorageService: AppThemeStorageService.shared,
            coordinator: self
        )
        settingsViewController.presenter = settingsPresenter
        navigationController.pushViewController(settingsViewController, animated: true)
    }
}

extension SettingsCoordinator: SettingsCoordinatorProtocol {
    
    func pushToSettingsOptions(with model: SettingsOptionsModel, delegate: SettingsOptionsCoordinatorDelegate) {
        let settingsOptionsCoordinator = SettingsOptionsCoordinator(
            navigationController: navigationController,
            options: model
        )
        settingsOptionsCoordinator.delegate = delegate
        coordinate(to: settingsOptionsCoordinator)
    }
}
