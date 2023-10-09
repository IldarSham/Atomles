//
//  CharactersListPresenter.swift
//  Atomles
//
//  Created by Ildar on 15.09.2022.
//

import Foundation

class CharactersListPresenter {
    
    // MARK: - Properties
    weak var view: CharactersListViewProtocol!
    private let charactersService: CharactersServiceProtocol
    private let coordinator: CharactersListFlow
    
    var fetchedData = [CharactersModel]()
    var displayedData = [CharacterCellModel]()
    
    // MARK: - Initialization
    init(view: CharactersListViewProtocol,
         charactersService: CharactersServiceProtocol,
         coordinator: CharactersListFlow) {
        
        self.view = view
        self.charactersService = charactersService
        self.coordinator = coordinator
    }
    
    // MARK: Public methods
    func fetchListOfCharacters() {
        charactersService.getAllCharacters { (result: Result<[CharactersModel]>) in
            switch result {
            case .success(let characters):
                self.fetchCharactersSuccess(characters: characters)
            case .failure(let error):
                self.fetchCharactersFailure(error: error)
            }
        }
    }
    
    func fetchCharactersSuccess(characters: [CharactersModel]) {
        fetchedData = characters
        displayedData = convertToViewModel(characters: characters)
        view.onFetchCharactersSuccess()
    }
    
    func fetchCharactersFailure(error: Error) {
        view.onFetchCharactersFailure(error: error)
    }
    
    func convertToViewModel(characters: [CharactersModel]) -> [CharacterCellModel] {
        return characters.map { CharacterCellModel(name: $0.name, thumbnailImageUrl: $0.thumbnailImageUrl) }
    }
}

// MARK: - Presenter Protocol
extension CharactersListPresenter: CharactersListPresenterProtocol {
        
    func viewDidLoad() {
        fetchListOfCharacters()
    }
    
    func numberOfItemsInSection() -> Int {
        return displayedData.count
    }
    
    func getCellModel(for index: Int) -> CharacterCellModel {
        return displayedData[index]
    }
    
    func didSelectItemAt(index: Int) {
        coordinator.coordinateToDetail(with: fetchedData[index].id)
    }
}
