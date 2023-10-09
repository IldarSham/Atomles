//
//  CharacterDetailContract.swift
//  Atomles
//
//  Created by Ildar Shamsullin on 12.02.2023.
//

import Foundation

protocol SettingsViewProtocol: AnyObject {
    func reloadData()
    func setAppTheme(_ theme: AppTheme)
}

protocol SettingsPresenterProtocol {
    func didSelectRowAt(index: Int)
    func numberOfRowsInSection() -> Int
    func getSettingsCellModel(for index: Int) -> SettingsCellModel
}
