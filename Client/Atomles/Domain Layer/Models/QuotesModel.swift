//
//  QuotesModel.swift
//  Atomles
//
//  Created by Ildar Shamsullin on 15.11.2022.
//

import Foundation

struct QuotesModel: Decodable {
    var characterImageUrl: String
    var quoteText: String
    var copyrightName: String
    
    enum CodingKeys: String, CodingKey {
        case characterImageUrl = "character_image_url", quoteText = "quote_text", copyrightName = "copyright_name"
    }
}
