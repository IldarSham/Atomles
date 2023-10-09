//
//  SeriesDetailPresenter.swift
//  Atomles
//
//  Created by Ildar on 12.08.2022.
//

import Foundation

class SeriesDetailPresenter {
    
    // MARK: - Properties
    weak var view: SeriesDetailViewProtocol!
    let series: SeriesModel
    
    // MARK: - Initialization
    init(view: SeriesDetailViewProtocol, series: SeriesModel) {
        self.view = view
        self.series = series
    }
    
    func linkToRequest(_ link: String) -> URLRequest? {
        guard let url = URL(string: link) else {
            return nil
        }
        return URLRequest(url: url)
    }
}

// MARK: - Presenter Protocol
extension SeriesDetailPresenter: SeriesDetailPresenterProtocol {
    
    func viewDidLoad() {
        guard let request = linkToRequest(series.link) else { return }
        view.setupNavigationItem(with: series.title)
        view.loadInWebView(request)
    }
}
