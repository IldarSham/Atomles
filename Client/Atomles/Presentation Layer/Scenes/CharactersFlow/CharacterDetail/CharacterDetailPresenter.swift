//
//  CharacterDetailPresenter.swift
//  Atomles
//
//  Created by Ildar Shamsullin on 07.11.2022.
//

import Foundation

class CharacterDetailPresenter {
    
    // MARK: - Properties
    weak var view: CharacterDetailViewProtocol!
    private let charactersService: CharactersServiceProtocol
    private let characterId: Int
    
    var fetchedData: CharacterDetailModel?
    
    // MARK: - Initialization
    init(view: CharacterDetailViewProtocol,
         charactersService: CharactersServiceProtocol,
         characterId: Int) {
        self.view = view
        self.charactersService = charactersService
        self.characterId = characterId
    }
    
    func fetchCharacterDetail() {
        charactersService.getCharacterDetail(by: characterId) { (result: Result<CharacterDetailModel>) in
            switch result {
            case .success(let characters):
                self.fetchCharacterDetailSuccess(characterDetail: characters)
            case .failure(let error):
                self.fetchCharacterDetailFailure(error: error)
            }
        }
    }
    
    func fetchCharacterDetailSuccess(characterDetail: CharacterDetailModel) {
        self.fetchedData = characterDetail
        view.setNavigationTitle(title: characterDetail.name)
        view.onFetchCharacterDetailSuccess()
    }
    
    func fetchCharacterDetailFailure(error: Error) {
        view.onFetchCharacterDetailFailure(error: error)
    }
}

extension CharacterDetailPresenter: CharacterDetailPresenterProtocol {
    
    func viewDidLoad() {
        fetchCharacterDetail()
    }
    
    func getGalleryCellModel() -> GalleryCellViewModel? {
        guard let fetchedData = fetchedData else {
            return nil
        }
        
        return GalleryCellViewModel(galleryImagesUrls: fetchedData.galleryImagesUrls)
    }
    
    func getDescriptionCellModel() -> DescriptionCellViewModel? {
        guard let fetchedData = fetchedData else {
            return nil
        }
        
        return DescriptionCellViewModel(description: fetchedData.description)
    }
}
