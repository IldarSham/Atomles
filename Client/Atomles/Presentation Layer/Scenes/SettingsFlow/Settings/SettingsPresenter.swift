//
//  SettingsPresenter.swift
//  Atomles
//
//  Created by Ildar Shamsullin on 16.03.2023.
//

import Foundation

class SettingsPresenter {
    
    // MARK: - Properties
    weak var view: SettingsViewProtocol!
    private let appThemeStorageService: AppThemeStorageServiceProtocol
    private let coordinator: SettingsCoordinatorProtocol
    
    private var rows: [SettingsCellModel] {
        return [
            SettingsCellModel(
                title: "Тема",
                type: .stringValue(value: appThemeStorageService.getCurrentTheme().title),
                selection: true
            )
        ]
    }
    
    private let availableThemes = AppTheme.allCases.map { $0.title }
        
    init(view: SettingsViewProtocol,
         appThemeStorageService: AppThemeStorageServiceProtocol,
         coordinator: SettingsCoordinator) {
        self.view = view
        self.appThemeStorageService = appThemeStorageService
        self.coordinator = coordinator
    }

    private func getSettingsOptionsModel(index: Int) -> SettingsOptionsModel {
        return SettingsOptionsModel(
            title: rows[index].title,
            options: availableThemes,
            selectedIndex: appThemeStorageService.getCurrentTheme().rawValue
        )
    }
}

extension SettingsPresenter: SettingsPresenterProtocol {
    
    func didSelectRowAt(index: Int) {
        let settingsOptionsModel = getSettingsOptionsModel(index: index)
        coordinator.pushToSettingsOptions(with: settingsOptionsModel, delegate: self)
    }
    
    func numberOfRowsInSection() -> Int {
        return rows.count
    }
    
    func getSettingsCellModel(for index: Int) -> SettingsCellModel {
        return rows[index]
    }
}

extension SettingsPresenter: SettingsOptionsCoordinatorDelegate {
    
    func didSelectOption(index: Int) {
        guard let theme = AppTheme(rawValue: index) else { return }
        
        appThemeStorageService.setTheme(theme)
        
        view.setAppTheme(theme)
        view.reloadData()
    }
}

extension AppTheme {
    
    var title: String {
        switch self {
        case .system:
            return "Системная"
        case .light:
            return "Светлая"
        case .dark:
            return "Темная"
        }
    }
}
