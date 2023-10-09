//
//  SeriesListCoordinator.swift
//  Atomles
//
//  Created by Ildar on 09.06.2022.
//

import UIKit

protocol SeriesListCoordinatorProtocol {
    func pushToSeriesDetail(with series: SeriesModel)
}

class SeriesListCoordinator: Coordinator {
    
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let seriesListViewController = SeriesListViewController()
        let seriesListPresenter = SeriesListPresenter(
            view: seriesListViewController,
            seriesService: SeriesService(),
            storageService: WatchedSeriesStorageService(),
            coordinator: self
        )
        seriesListViewController.presenter = seriesListPresenter
        seriesListViewController.imageClient = ImageClient.shared
        
        navigationController.pushViewController(seriesListViewController, animated: true)
    }
}

extension SeriesListCoordinator: SeriesListCoordinatorProtocol {
    
    func pushToSeriesDetail(with series: SeriesModel) {
        let seriesDetailCoordinator = SeriesDetailCoordinator(
            navigationController: navigationController,
            series: series
        )
        coordinate(to: seriesDetailCoordinator)
    }
}
