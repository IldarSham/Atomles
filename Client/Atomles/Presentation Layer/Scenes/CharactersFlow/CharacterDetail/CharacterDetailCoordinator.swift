//
//  CharacterDetailCoordinator.swift
//  Atomles
//
//  Created by Ildar Shamsullin on 07.11.2022.
//

import UIKit

class CharacterDetailCoordinator: Coordinator {
    
    let navigationController: UINavigationController
    let characterId: Int
    
    init(navigationController: UINavigationController, characterId: Int) {
        self.navigationController = navigationController
        self.characterId = characterId
    }
    
    func start() {
        let characterDetailViewController = CharacterDetailViewController()
        let characterDetailPresenter = CharacterDetailPresenter(
            view: characterDetailViewController,
            charactersService: CharactersService(),
            characterId: characterId
        )
        characterDetailViewController.presenter = characterDetailPresenter
        characterDetailViewController.imageClient = ImageClient.shared
        
        navigationController.pushViewController(characterDetailViewController, animated: true)
    }
}
