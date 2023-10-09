//
//  ImageClient.swift
//  Atomles
//
//  Created by Ildar Shamsullin on 21.03.2023.
//

import UIKit

protocol ImageClientProtocol {
    func downloadImage(fromURL url: String, completion: @escaping (UIImage?, Error?) -> Void)
    func setImage(on imageView: UIImageView, fromURL url: String, withPlaceholder placeholder: UIImage?, completion: (() -> Void)?)
}

extension ImageClientProtocol {
    func setImage(on imageView: UIImageView, fromURL url: String) {
        self.setImage(on: imageView, fromURL: url, withPlaceholder: nil, completion: nil)
    }
}

class ImageClient: ImageClientProtocol {
    
    // MARK: - Static Properties
    
    static let shared = ImageClient()
    
    // MARK: - Instance Properties
    
    var cachedImageForURL: [String: UIImage]
    let sessionManager: SessionManagerProtocol
    
    // MARK: - Object Lifecycle
    
    init(sessionManager: SessionManagerProtocol = SessionManager()) {
        self.cachedImageForURL = [:]
        self.sessionManager = sessionManager
    }
    
    func downloadImage(fromURL url: String, completion: @escaping (UIImage?, Error?) -> Void) {
        if let image = cachedImageForURL[url] {
            completion(image, nil)
            return
        }
        
        let request = ImageRequest(url: url)
        sessionManager.perform(request) { [weak self] response in
            guard let self = self else { return }
            switch response {
            case .success(let data):
                if let image = UIImage(data: data) {
                    self.cachedImageForURL[url] = image
                    self.dispatch(image: image, completion: completion)
                }
            case .failure(let error):
                self.dispatch(error: error, completion: completion)
            }
        }
    }
    
    private func dispatch(image: UIImage? = nil, error: Error? = nil, completion: @escaping (UIImage?, Error?) -> Void) {
        DispatchQueue.main.async {
            completion(image, error)
        }
    }
    
    func setImage(on imageView: UIImageView, fromURL url: String, withPlaceholder placeholder: UIImage? = nil, completion: (() -> Void)? = nil) {
        imageView.image = placeholder
        
        downloadImage(fromURL: url) { image, error in
            guard let image = image else {
                print("Set Image failed with error: " + String(describing: error))
                return
            }
            imageView.image = image
            completion?()
        }
    }
}
