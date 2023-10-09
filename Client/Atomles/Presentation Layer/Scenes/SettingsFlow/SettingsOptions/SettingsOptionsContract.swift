//
//  SettingsOptionsContract.swift
//  Atomles
//
//  Created by Ildar Shamsullin on 17.03.2023.
//

import Foundation

protocol SettingsOptionsViewProtocol: AnyObject {
    func setupNavigationItem(with title: String)
}

protocol SettingsOptionsPresenterProtocol {
    func viewDidLoad()
    func numberOfRowsInSection() -> Int
    func getSettingsOptionsCellModel(index: Int) -> SettingsOptionsCellModel
    func didSelectRowAt(index: Int)
}
