//
//  SessionManager.swift
//  Atomles
//
//  Created by Ildar on 10.10.2022.
//

import Foundation

protocol SessionManagerProtocol {
    
    typealias ServerResponseHandler = (Result<Data>) -> Void
    func perform(_ request: RequestProtocol, handler: @escaping ServerResponseHandler)
}

class SessionManager: SessionManagerProtocol {

    private let urlSession: URLSession
    
    init(urlSession: URLSession = URLSession.shared) {
        self.urlSession = urlSession
    }
    
    func perform(_ request: RequestProtocol, handler: @escaping ServerResponseHandler) {
        urlSession.dataTask(with: request.asURLRequest()) { (data, response, error) in
            let result: Result<Data>
            defer {
                DispatchQueue.main.async {
                    handler(result)
                }
            }
            if let response = response as? HTTPURLResponse, (200..<300) ~= response.statusCode {
                guard let data = data else { return result = .failure(NetworkError.invalidData) }
                result = .success(data)
            } else {
                result = .failure(NetworkError.invalidServerResponse)
            }
        }.resume()
    }
}
