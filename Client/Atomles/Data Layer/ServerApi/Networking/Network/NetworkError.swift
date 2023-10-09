//
//  NetworkError.swift
//  Atomles
//
//  Created by Ildar on 10.10.2022.
//

import Foundation

enum NetworkError: Error {
    case invalidServerResponse
    case invalidData
    case decodingFailed
}
