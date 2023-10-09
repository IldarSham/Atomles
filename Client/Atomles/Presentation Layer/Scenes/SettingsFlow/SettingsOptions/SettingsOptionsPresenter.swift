//
//  SettingsOptionsPresenter.swift
//  Atomles
//
//  Created by Ildar Shamsullin on 17.03.2023.
//

import Foundation

class SettingsOptionsPresenter {
    
    // MARK: - Properties
    weak var view: SettingsOptionsViewProtocol!
    private let options: SettingsOptionsModel
    private let cooridinator: SettingsOptionsCoordinator
    
    init(view: SettingsOptionsViewProtocol, options: SettingsOptionsModel, coordinator: SettingsOptionsCoordinator) {
        self.view = view
        self.options = options
        self.cooridinator = coordinator
    }
}

extension SettingsOptionsPresenter: SettingsOptionsPresenterProtocol {
    
    func viewDidLoad() {
        view.setupNavigationItem(with: options.title)
    }
    
    func numberOfRowsInSection() -> Int {
        return options.options.count
    }
    
    func getSettingsOptionsCellModel(index: Int) -> SettingsOptionsCellModel {
        return SettingsOptionsCellModel(
            optionText: options.options[index],
            isSelected: options.selectedIndex == index
        )
    }
    
    func didSelectRowAt(index: Int) {
        cooridinator.handleSelectedOption(index: index)
    }
}
