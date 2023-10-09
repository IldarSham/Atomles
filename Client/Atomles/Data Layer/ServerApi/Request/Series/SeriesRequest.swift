//
//  SeriesRequest.swift
//  Atomles
//
//  Created by Ildar on 10.10.2022.
//

import Foundation

enum SeriesRequest: RequestProtocol {
    
    case getAllSeries
    
    var path: String? {
        "/series"
    }
    
    var requestType: RequestType {
        .get
    }
}
