//
//  CharactersRequest.swift
//  Atomles
//
//  Created by Ildar on 10.10.2022.
//

import Foundation

enum CharactersRequest: RequestProtocol {
    
    case getAllCharacters
    case getCharacterDetailBy(id: Int)
    
    var path: String? {
        switch self {
        case .getAllCharacters:
            return "/characters"
        case .getCharacterDetailBy:
            return "/characters/detail"
        }
    }

    var queryItems: [String: String]? {
        switch self {
        case .getAllCharacters:
            return nil
        case .getCharacterDetailBy(let id):
            return ["id": String(id)]
        }
    }
    
    var requestType: RequestType {
        .get
    }
}
