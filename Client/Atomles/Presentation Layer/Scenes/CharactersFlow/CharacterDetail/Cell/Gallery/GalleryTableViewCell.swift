//
//  GalleryCell.swift
//  Atomles
//
//  Created by Ildar Shamsullin on 07.11.2022.
//

import UIKit

struct GalleryCellViewModel {
    let galleryImagesUrls: [String]
}

class GalleryTableViewCell: UITableViewCell {
    
    // MARK: - Initialization
    init(viewModel: GalleryCellViewModel, imageClient: ImageClientProtocol) {
        self.viewModel = viewModel
        self.imageClient = imageClient
        super.init(style: .default, reuseIdentifier: GalleryTableViewCell.reuseIdentifier)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Properties
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())
        collectionView.contentInset = UIEdgeInsets(top: 0, left: Constants.contentInset, bottom: 0, right: Constants.contentInset)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CharacterCollectionViewCell.self, forCellWithReuseIdentifier: CharacterCollectionViewCell.reuseIdentifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private let viewModel: GalleryCellViewModel
    private let imageClient: ImageClientProtocol
}

// MARK: - UICollectionView Delegate & Data Source
extension GalleryTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.galleryImagesUrls.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let url = viewModel.galleryImagesUrls[indexPath.item]

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharacterCollectionViewCell.reuseIdentifier, for: indexPath) as! CharacterCollectionViewCell
        
        imageClient.setImage(on: cell.imageView, fromURL: url, withPlaceholder: nil, completion: nil)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width - Constants.contentInset * 2
        return CGSize(width: width, height: collectionView.frame.height)
    }
}

// MARK: - UI Setup
extension GalleryTableViewCell {
    
    private func setupUI() {
        self.contentView.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.bottomAnchor)
        ])
    }
    
    private func collectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = Constants.minimumLineSpacing
        return layout
    }
}

// MARK: - Constants
extension GalleryTableViewCell {
    
    private enum Constants {
        static let minimumLineSpacing: CGFloat = 10.0
        static let contentInset: CGFloat = 20.0
    }
}
