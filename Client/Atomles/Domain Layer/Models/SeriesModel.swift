//
//  SeriesModel.swift
//  Atomles
//
//  Created by Ildar on 10.06.2022.
//

import Foundation

struct SeriesModel: Decodable {
    var id: Int
    var season: Int
    var episode: Int
    var previewImageUrl: String
    var title: String
    var description: String
    var link: String
    
    enum CodingKeys: String, CodingKey {
        case id, season, episode, previewImageUrl = "preview_image_url", title, description, link
    }
}
