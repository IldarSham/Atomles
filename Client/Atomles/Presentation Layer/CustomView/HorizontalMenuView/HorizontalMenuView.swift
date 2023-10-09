//
//  HorizontalMenuView.swift
//  Atomles
//
//  Created by Ildar on 03.07.2022.
//

import UIKit

protocol HorizontalMenuViewDelegate: AnyObject {
    func didSelectItem(at index: Int)
}

class HorizontalMenuView: UIView {
    
    // MARK: - Initialization
    init(items: [String]) {
        self.items = items
        super.init(frame: .zero)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Properties
    weak var delegate: HorizontalMenuViewDelegate?
    
    var items: [String] {
        didSet {
            collectionView.reloadData()
        }
    }
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout
        )
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.alwaysBounceHorizontal = false
        collectionView.register(HorizontalMenuCollectionViewCell.self, forCellWithReuseIdentifier: HorizontalMenuCollectionViewCell.reuseIdentifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.translatesAutoresizingMaskIntoConstraints =  false
        collectionView.selectItem(at: IndexPath(item: 0, section: 0), animated: true, scrollPosition: [])
        return collectionView
    }()
    
    // MARK: - Public methods
    func selectItem(at index: Int) {
        collectionView.selectItem(at: IndexPath(item: index, section: 0), animated: true, scrollPosition: [])
    }
}

// MARK: - UICollectionView Delegate & Data Source
extension HorizontalMenuView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HorizontalMenuCollectionViewCell.reuseIdentifier, for: indexPath) as! HorizontalMenuCollectionViewCell
        
        cell.titleLabel.text = items[indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.selectItem(at: indexPath, animated: true, scrollPosition: [])
        delegate?.didSelectItem(at: indexPath.item)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 90, height: collectionView.frame.height)
    }
}

// MARK: - UI Setup
extension HorizontalMenuView {
    func setupUI() {
        self.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.widthAnchor.constraint(equalTo: self.widthAnchor),
            collectionView.heightAnchor.constraint(equalTo: self.heightAnchor)
        ])
    }
}
