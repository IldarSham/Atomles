//
//  CharacterDetailModel.swift
//  Atomles
//
//  Created by Ildar Shamsullin on 07.11.2022.
//

import Foundation

struct CharacterDetailModel: Decodable {
    var id: Int
    var name: String
    var galleryImagesUrls: [String]
    var description: String
    
    enum CodingKeys: String, CodingKey {
        case id, name, galleryImagesUrls = "gallery_images_urls", description
    }
}
