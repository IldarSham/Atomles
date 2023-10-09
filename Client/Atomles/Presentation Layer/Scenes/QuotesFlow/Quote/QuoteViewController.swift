//
//  QuoteViewController.swift
//  Atomles
//
//  Created by Ildar Shamsullin on 23.11.2022.
//

import UIKit

struct QuoteViewModel {
    var characterImageUrl: String
    var quoteText: String
    var copyrightName: String
}

class QuoteViewController: UIViewController {
        
    // MARK: - Initialization
    init(pageIndex: Int) {
        super.init(nibName: nil, bundle: nil)
        self.pageIndex = pageIndex
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        setupUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        overlayLayer.frame = imageView.bounds
    }

    // MARK: - Properties
    var pageIndex: Int = 0
    
    private(set) var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 15.0
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let overlayLayer: CALayer = {
        let layer = CALayer()
        layer.backgroundColor = UIColor.black.cgColor
        layer.opacity = 0.6
        return layer
    }()
    
    private let markLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont(name: "Thonburi", size: 110)!
        label.textAlignment = .center
        label.text = "“"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let textLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .white
        label.font = UIFont(name: "DINCondensed-Bold", size: 33)!
        label.textAlignment = .center
        label.layer.shadowOffset = CGSize(width: 3, height: 3)
        label.layer.shadowOpacity = 0.8
        label.layer.shadowRadius = 1
        label.layer.shadowColor = UIColor.black.cgColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let copyrightLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont(name: "HelveticaNeue-Light", size: 27)!
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
}

// MARK: - Public methods
extension QuoteViewController {
    
    func configure(_ viewModel: QuoteViewModel) {
        textLabel.text = viewModel.quoteText
        copyrightLabel.text = viewModel.copyrightName
    }
}

// MARK: - UI Setup
extension QuoteViewController {
    
    func setupUI() {
        self.view.addSubview(imageView)
        imageView.layer.addSublayer(overlayLayer)
        imageView.addSubview(markLabel)
        imageView.addSubview(textLabel)
    
        self.view.addSubview(copyrightLabel)
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10),
            imageView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10),
            imageView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 10),
            imageView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -10)
        ])
        
        NSLayoutConstraint.activate([
            textLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: 15),
            textLabel.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: -15),
            textLabel.centerXAnchor.constraint(equalTo: imageView.centerXAnchor),
            textLabel.centerYAnchor.constraint(equalTo: imageView.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            markLabel.centerXAnchor.constraint(equalTo: textLabel.centerXAnchor),
            markLabel.topAnchor.constraint(equalTo: textLabel.topAnchor, constant: -90)
        ])
        
        NSLayoutConstraint.activate([
            copyrightLabel.centerXAnchor.constraint(equalTo: textLabel.centerXAnchor),
            copyrightLabel.topAnchor.constraint(equalTo: textLabel.bottomAnchor, constant: 30)
        ])
    }
}
