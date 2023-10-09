//
//  QuotesRequest.swift
//  Atomles
//
//  Created by Ildar Shamsullin on 15.11.2022.
//

import Foundation

enum QuotesRequest: RequestProtocol {
    
    case getAllQuotes
    
    var path: String? {
        "/quotes"
    }
    
    var requestType: RequestType {
        .get
    }
}
