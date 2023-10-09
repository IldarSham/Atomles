//
//  AppThemeStorageService.swift
//  Atomles
//
//  Created by Ildar Shamsullin on 16.03.2023.
//

import Foundation

protocol AppThemeStorage {
    var appThemeId: Int { get set }
}

protocol AppThemeStorageServiceProtocol {
    func getCurrentTheme() -> AppTheme
    func setTheme(_ appTheme: AppTheme)
}

class AppThemeStorageService: AppThemeStorageServiceProtocol {
    
    static let shared = AppThemeStorageService()
    
    private var storage: AppThemeStorage
    
    init(storage: AppThemeStorage = UserDefaultsLayer()) {
        self.storage = storage
    }
    
    func getCurrentTheme() -> AppTheme {
        return AppTheme(rawValue: storage.appThemeId) ?? .system
    }
    
    func setTheme(_ appTheme: AppTheme) {
        storage.appThemeId = appTheme.rawValue
    }
}
