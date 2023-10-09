//
//  QuotesListContract.swift
//  Atomles
//
//  Created by Ildar Shamsullin on 15.11.2022.
//

import Foundation

protocol QuotesListViewProtocol: AnyObject {
    func onFetchQuotesSuccess()
    func onFetchQuotesFailure(error: Error)
}

protocol QuotesListPresenterProtocol {
    var numberOfQuotes: Int { get }

    func viewDidLoad()
    func getQuoteViewModel(for index: Int) -> QuoteViewModel
}
