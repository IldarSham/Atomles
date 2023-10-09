//
//  QuotesService.swift
//  Atomles
//
//  Created by Ildar Shamsullin on 15.11.2022.
//

import Foundation

typealias GetAllQuotesCompletionHandler = (Result<[QuotesModel]>) -> ()

protocol QuotesServiceProtocol {
    func getAllQuotes(_ completionHandler: @escaping GetAllQuotesCompletionHandler)
}

class QuotesService: QuotesServiceProtocol {

    private let apiManager: APIManagerProtocol
    
    init(apiManager: APIManagerProtocol = APIManager()) {
        self.apiManager = apiManager
    }
    
    func getAllQuotes(_ completionHandler: @escaping GetAllQuotesCompletionHandler) {
        apiManager.call(QuotesRequest.getAllQuotes) { (result: Result<[QuotesModel]>) in
            completionHandler(result)
        }
    }
}

