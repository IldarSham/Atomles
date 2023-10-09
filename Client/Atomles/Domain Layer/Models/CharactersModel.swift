//
//  CharactersModel.swift
//  Atomles
//
//  Created by Ildar on 15.09.2022.
//

import Foundation

struct CharactersModel: Decodable {
    var id: Int
    var name: String
    var thumbnailImageUrl: String
    
    enum CodingKeys: String, CodingKey {
        case id, name, thumbnailImageUrl = "thumbnail_image_url"
    }
}
