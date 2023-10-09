//
//  RequestProtocol.swift
//  Atomles
//
//  Created by Ildar on 10.10.2022.
//

import Foundation

protocol RequestProtocol {
    var url: String { get }
    var path: String? { get }
    var requestType: RequestType { get }
    var queryItems: [String: String]? { get }
    var headers: [String: String]? { get }
    
    func asURLRequest() -> URLRequest
}

extension RequestProtocol {
    func asURLRequest() -> URLRequest {
        var components = URLComponents(string: url)!
        if let path = path {
            components.path = path
        }

        if let urlParams = queryItems {
            components.queryItems = urlParams.map { URLQueryItem(name: $0, value: $1) }
        }

        let url = components.url!

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = requestType.rawValue

        if let headers = headers {
            urlRequest.allHTTPHeaderFields = headers
        }
        
        return urlRequest
    }
}

// MARK: - Default RequestProtocol
extension RequestProtocol {
    var url: String { APIConstants.baseURL }
    var path: String? { nil }
    var queryItems: [String: String]? { nil }
    var headers: [String: String]? { nil }
}
