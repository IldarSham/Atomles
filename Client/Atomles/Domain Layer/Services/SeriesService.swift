//
//  SeriesService.swift
//  Atomles
//
//  Created by Ildar on 10.06.2022.
//

import Foundation

typealias GetAllSeriesCompletionHandler = (Result<[SeriesModel]>) -> ()

protocol SeriesServiceProtocol {
    func getAllSeries(_ completionHandler: @escaping GetAllSeriesCompletionHandler)
}

class SeriesService: SeriesServiceProtocol {

    private let apiManager: APIManagerProtocol
    
    init(apiManager: APIManagerProtocol = APIManager()) {
        self.apiManager = apiManager
    }
    
    func getAllSeries(_ completionHandler: @escaping GetAllSeriesCompletionHandler) {
        apiManager.call(SeriesRequest.getAllSeries) { (result: Result<[SeriesModel]>) in
            completionHandler(result)
        }
    }
}
