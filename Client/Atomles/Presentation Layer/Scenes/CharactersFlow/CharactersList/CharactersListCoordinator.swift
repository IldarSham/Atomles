//
//  CharactersListCoordinator.swift
//  Atomles
//
//  Created by Ildar on 14.09.2022.
//

import UIKit

protocol CharactersListFlow {
    func coordinateToDetail(with characterId: Int)
}

class CharactersListCoordinator: Coordinator, CharactersListFlow {
    
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let charactersListViewController = CharactersListViewController()
        let charactersListPresenter = CharactersListPresenter(
            view: charactersListViewController,
            charactersService: CharactersService(),
            coordinator: self
        )
        charactersListViewController.presenter = charactersListPresenter
        charactersListViewController.imageClient = ImageClient.shared
        navigationController.pushViewController(charactersListViewController, animated: true)
    }
    
    // MARK: - Flow Methods
    func coordinateToDetail(with characterId: Int) {
        let characterDetailCoordinator = CharacterDetailCoordinator(
            navigationController: navigationController,
            characterId: characterId
        )
        
        coordinate(to: characterDetailCoordinator)
    }
}
