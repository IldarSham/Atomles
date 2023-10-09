//
//  CharactersService.swift
//  Atomles
//
//  Created by Ildar on 15.09.2022.
//

import Foundation

typealias GetAllCharactersCompletionHandler = (Result<[CharactersModel]>) -> ()
typealias GetCharacterDetailCompletionHandler = (Result<CharacterDetailModel>) -> ()

protocol CharactersServiceProtocol {
    func getAllCharacters(_ completionHandler: @escaping GetAllCharactersCompletionHandler)
    func getCharacterDetail(by id: Int, _ completionHandler: @escaping GetCharacterDetailCompletionHandler)
}

class CharactersService: CharactersServiceProtocol {
    
    private let apiManager: APIManagerProtocol
    
    init(apiManager: APIManagerProtocol = APIManager()) {
        self.apiManager = apiManager
    }
    
    func getAllCharacters(_ completionHandler: @escaping GetAllCharactersCompletionHandler) {
        apiManager.call(CharactersRequest.getAllCharacters) { (result: Result<[CharactersModel]>) in
            completionHandler(result)
        }
    }
    
    func getCharacterDetail(by id: Int, _ completionHandler: @escaping GetCharacterDetailCompletionHandler) {
        apiManager.call(CharactersRequest.getCharacterDetailBy(id: id)) { (result: Result<CharacterDetailModel>) in
            completionHandler(result)
        }
    }
}
