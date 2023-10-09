//
//  CharacterImageCell.swift
//  Atomles
//
//  Created by Ildar Shamsullin on 07.11.2022.
//

import UIKit

class CharacterCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
    
    // MARK: - Properties
    private(set) var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 8.0
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
}

// MARK: - UI Setup
extension CharacterCollectionViewCell {
    
    private func setupUI() {
        self.contentView.addSubview(imageView)
    
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalTo: self.contentView.widthAnchor),
            imageView.heightAnchor.constraint(equalTo: self.contentView.heightAnchor)
        ])
    }
}
