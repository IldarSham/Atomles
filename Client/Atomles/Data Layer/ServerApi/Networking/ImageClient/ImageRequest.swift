//
//  ImageRequest.swift
//  Atomles
//
//  Created by Ildar Shamsullin on 21.03.2023.
//

import Foundation

struct ImageRequest: RequestProtocol {
    let url: String
    
    var requestType: RequestType {
        .get
    }
}
