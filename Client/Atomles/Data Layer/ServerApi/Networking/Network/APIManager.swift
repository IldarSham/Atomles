//
//  APIManager.swift
//  Atomles
//
//  Created by Ildar on 10.10.2022.
//

import Foundation

protocol APIManagerProtocol {
    
    typealias ApiResponseHandler<T> = (Result<T>) -> Void
    func call<T: Decodable>(_ request: RequestProtocol, handler: @escaping ApiResponseHandler<T>)
}

class APIManager: APIManagerProtocol {
    
    private let sessionManager: SessionManagerProtocol
    
    init(sessionManager: SessionManagerProtocol = SessionManager()) {
        self.sessionManager = sessionManager
    }
    
    func call<T: Decodable>(_ request: RequestProtocol, handler: @escaping ApiResponseHandler<T>) {
        sessionManager.perform(request) { response in
            switch response {
            case .success(let data):
                do {
                    let decoded = try JSONDecoder().decode(T.self, from: data)
                    handler(.success(decoded))
                } catch {
                    handler(.failure(NetworkError.decodingFailed))
                }
            case .failure(let error):
                handler(.failure(error))
            }
        }
    }
}
