//
//  CharacterCell.swift
//  Atomles
//
//  Created by Ildar on 19.10.2022.
//

import UIKit

struct CharacterCellModel {
    let name: String
    let thumbnailImageUrl: String
}

class CharacterCell: UICollectionViewCell {
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Properties
    private(set) var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.style = .large
        indicator.color = #colorLiteral(red: 0.2549998119, green: 0.4515720169, blue: 0.1347271782, alpha: 1)
        indicator.hidesWhenStopped = true
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    private(set) lazy var characterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 8.0
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = #colorLiteral(red: 0.831372549, green: 0.8117647059, blue: 0.8274509804, alpha: 1)
        imageView.clipsToBounds = true
        imageView.backgroundColor = .black.withAlphaComponent(0.1)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        let gradientLayer: CAGradientLayer = {
            let layer = CAGradientLayer()
            layer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
            layer.frame = self.bounds
            layer.locations = [0.5, 1.0]
            return layer
        }()
        imageView.layer.addSublayer(gradientLayer)
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 15, weight: .heavy)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
}

// MARK: - Public methods
extension CharacterCell {

    func configure(_ viewModel: CharacterCellModel) {
        nameLabel.text = viewModel.name
        activityIndicator.startAnimating()
    }
    
    func flash() {
        characterImageView.alpha = 0
        UIView.animate(withDuration: 0.5, animations: { [weak self] in
            self?.characterImageView.alpha = 1
        })
    }
}

// MARK: - UI Setup
extension CharacterCell {
    
    func setupUI() {
        self.contentView.addSubview(characterImageView)
        characterImageView.addSubview(nameLabel)
        
        self.contentView.addSubview(activityIndicator)
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            characterImageView.widthAnchor.constraint(equalTo: self.contentView.widthAnchor),
            characterImageView.heightAnchor.constraint(equalTo: self.contentView.heightAnchor)
        ])
        
        NSLayoutConstraint.activate([
            nameLabel.centerXAnchor.constraint(equalTo: characterImageView.centerXAnchor),
            nameLabel.bottomAnchor.constraint(equalTo: characterImageView.bottomAnchor, constant: -10.0)
        ])
    }
}
