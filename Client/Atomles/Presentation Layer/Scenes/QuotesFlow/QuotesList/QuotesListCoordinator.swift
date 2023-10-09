//
//  QuotesListCoordinator.swift
//  Atomles
//
//  Created by Ildar Shamsullin on 14.11.2022.
//

import UIKit

class QuotesListCoordinator: Coordinator {
    
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let quotesListViewController = QuotesListViewController()
        let quotesListPresenter = QuotesListPresenter(
            view: quotesListViewController,
            quotesService: QuotesService()
        )
        quotesListViewController.presenter = quotesListPresenter
        quotesListViewController.imageClient = ImageClient.shared
        navigationController.pushViewController(quotesListViewController, animated: true)
    }
}
