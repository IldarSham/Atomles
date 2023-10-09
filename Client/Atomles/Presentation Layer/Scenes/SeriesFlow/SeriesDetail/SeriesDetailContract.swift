//
//  SeriesDetailContract.swift
//  Atomles
//
//  Created by Ildar on 12.09.2022.
//

import Foundation

protocol SeriesDetailViewProtocol: AnyObject {
    func loadInWebView(_ request: URLRequest)
    func setupNavigationItem(with title: String)
}

protocol SeriesDetailPresenterProtocol {
    func viewDidLoad()
}
