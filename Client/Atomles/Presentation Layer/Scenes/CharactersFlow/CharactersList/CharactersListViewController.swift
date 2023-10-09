//
//  CharactersListViewController.swift
//  Atomles
//
//  Created by Ildar on 14.09.2022.
//

import UIKit

class CharactersListViewController: UIViewController {

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupNavigationItem()
        
        presenter.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupNavigationBar()
    }
    
    // MARK: - Properties
    var presenter: CharactersListPresenterProtocol!
    var imageClient: ImageClientProtocol!
    
    private(set) lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())
        collectionView.contentInset = UIEdgeInsets(top: Constants.contentInset, left: Constants.contentInset, bottom: Constants.contentInset, right: Constants.contentInset)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(CharacterCell.self, forCellWithReuseIdentifier: CharacterCell.reuseIdentifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
}

// MARK: - View Protocol
extension CharactersListViewController: CharactersListViewProtocol {

    func onFetchCharactersSuccess() {
        collectionView.reloadData()
    }
    
    func onFetchCharactersFailure(error: Error) {
        print(error)
    }
}

// MARK: - UICollectionView DataSource
extension CharactersListViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.numberOfItemsInSection()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharacterCell.reuseIdentifier, for: indexPath) as! CharacterCell
        
        let viewModel = presenter.getCellModel(for: indexPath.item)
        cell.configure(viewModel)
        
        imageClient.setImage(on: cell.characterImageView, fromURL: viewModel.thumbnailImageUrl, withPlaceholder: nil) {
            cell.activityIndicator.stopAnimating()
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? CharacterCell {
            cell.flash()
        }
        presenter.didSelectItemAt(index: indexPath.item)
    }
}

// MARK: - UICollectionView DelegateFlowLayout
extension CharactersListViewController: UICollectionViewDelegateFlowLayout {
        
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = Constants.contentInset * 2 + Constants.minimumInteritemSpacing * (Constants.itemsPerRow - 1)
        let availableWidth = collectionView.frame.width - paddingSpace
        let widthPerItem = floor(availableWidth / Constants.itemsPerRow)
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
}

// MARK: - UI Setup
extension CharactersListViewController {
    
    private func setupUI() {
        self.view.backgroundColor = .systemBackground
        
        self.view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }
    
    private func setupNavigationBar() {
        self.navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    private func setupNavigationItem() {
        self.navigationItem.title = "Персонажи"
    }
    
    private func collectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = Constants.minimumLineSpacing
        layout.minimumInteritemSpacing = Constants.minimumInteritemSpacing
        return layout
    }
}

// MARK: - Constants
extension CharactersListViewController {
    
    private enum Constants {
        static let itemsPerRow: CGFloat = 2
        static let minimumLineSpacing: CGFloat = 10.0
        static let minimumInteritemSpacing: CGFloat = 10.0
        static let contentInset: CGFloat = 10.0
    }
}
