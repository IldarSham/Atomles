//
//  SeriesDetailCoordinator.swift
//  Atomles
//
//  Created by Ildar on 12.08.2022.
//

import UIKit

class SeriesDetailCoordinator: Coordinator {
    
    let navigationController: UINavigationController
    let series: SeriesModel
    
    init(navigationController: UINavigationController, series: SeriesModel) {
        self.navigationController = navigationController
        self.series = series
    }
    
    func start() {
        let seriesDetailViewController = SeriesDetailViewController()
        let seriesDetailPresenter = SeriesDetailPresenter(
            view: seriesDetailViewController,
            series: series
        )
        seriesDetailViewController.presenter = seriesDetailPresenter
        
        navigationController.pushViewController(seriesDetailViewController, animated: true)
    }
}
