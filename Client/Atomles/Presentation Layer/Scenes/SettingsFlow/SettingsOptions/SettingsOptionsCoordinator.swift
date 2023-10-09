//
//  SettingsOptionsCoordinator.swift
//  Atomles
//
//  Created by Ildar Shamsullin on 17.03.2023.
//

import UIKit

struct SettingsOptionsModel {
    let title: String
    let options: [String]
    let selectedIndex: Int
}

protocol SettingsOptionsCoordinatorProtocol {
    func handleSelectedOption(index: Int)
}

protocol SettingsOptionsCoordinatorDelegate: AnyObject {
    func didSelectOption(index: Int)
}

class SettingsOptionsCoordinator: Coordinator {
    
    let navigationController: UINavigationController
    let options: SettingsOptionsModel
    weak var delegate: SettingsOptionsCoordinatorDelegate!
    
    init(navigationController: UINavigationController, options: SettingsOptionsModel) {
        self.navigationController = navigationController
        self.options = options
    }
    
    func start() {
        let settingsOptionsViewController = SettingsOptionsViewController()
        let settingsOptionsPresenter = SettingsOptionsPresenter(
            view: settingsOptionsViewController,
            options: options,
            coordinator: self
        )
        settingsOptionsViewController.presenter = settingsOptionsPresenter
        navigationController.pushViewController(settingsOptionsViewController, animated: true)
    }
}

extension SettingsOptionsCoordinator: SettingsOptionsCoordinatorProtocol {
    
    func handleSelectedOption(index: Int) {
        navigationController.popViewController(animated: true)
        delegate.didSelectOption(index: index)
    }
}
