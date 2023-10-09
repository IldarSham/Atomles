//
//  QuotesListPresenter.swift
//  Atomles
//
//  Created by Ildar Shamsullin on 15.11.2022.
//

import Foundation

class QuotesListPresenter {
    
    // MARK: - Properties
    weak var view: QuotesListViewProtocol!
    private let quotesService: QuotesServiceProtocol
    
    var fetchedData = [QuotesModel]()
    var displayedData = [QuoteViewModel]()
    
    // MARK: - Initialization
    init(view: QuotesListViewProtocol, quotesService: QuotesServiceProtocol) {
        self.view = view
        self.quotesService = quotesService
    }
    
    // MARK: Public methods
    func fetchQuotesList() {
        quotesService.getAllQuotes { (result: Result<[QuotesModel]>) in
            switch result {
            case .success(let quotes):
                self.fetchQuotesSuccess(quotes: quotes)
            case .failure(let error):
                self.fetchQuotesFailure(error: error)
            }
        }
    }
    
    func fetchQuotesSuccess(quotes: [QuotesModel]) {
        fetchedData = quotes
        displayedData = convertToViewModel(quotes: quotes)
        view.onFetchQuotesSuccess()
    }
    
    func fetchQuotesFailure(error: Error) {
        view.onFetchQuotesFailure(error: error)
    }
    
    func convertToViewModel(quotes: [QuotesModel]) -> [QuoteViewModel] {
        return quotes.map { QuoteViewModel(characterImageUrl: $0.characterImageUrl, quoteText: $0.quoteText, copyrightName: $0.copyrightName) }
    }
}

// MARK: - Presenter Protocol
extension QuotesListPresenter: QuotesListPresenterProtocol {
    
    var numberOfQuotes: Int {
        displayedData.count
    }
    
    func viewDidLoad() {
        fetchQuotesList()
    }
    
    func getQuoteViewModel(for index: Int) -> QuoteViewModel {
        return displayedData[index]
    }
}
