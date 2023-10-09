//
//  SeriesListTableViewCell.swift
//  Atomles
//
//  Created by Ildar on 13.06.2022.
//

import UIKit

struct SeriesListCellModel {
    let title: String
    let season: SeasonsHorizontalMenuViewModel?
    let subtitle: String
    let previewImageUrl: String
    let description: String
    var isWatched: Bool
}

class SeriesListTableViewCell: UITableViewCell {

    // MARK: - Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        addGestureRecognizer()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Properties
    var didTapWatchedButton: (() -> Void)?
    
    private let watchedImageView: UIImageView = {
        let image = UIImageView()
        image.tintColor = UIColor(named: "watchedImage")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.textColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let episodeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 11)
        label.textColor = UIColor(named: "episodeText")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private(set) var previewImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    // MARK: - Actions
    @objc private func didTapWatchedImageView(sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            didTapWatchedButton?()
        }
    }
    
    // MARK: - Methods
    private func addGestureRecognizer() {
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(didTapWatchedImageView))
        watchedImageView.addGestureRecognizer(tapGR)
        watchedImageView.isUserInteractionEnabled = true
    }
}

// MARK: - Public methods
extension SeriesListTableViewCell {

    func configure(viewModel: SeriesListCellModel, onTapWatchedButton: @escaping () -> Void) {
        titleLabel.text = viewModel.title
        episodeLabel.text = viewModel.subtitle
        descriptionLabel.text = viewModel.description
        watchedImageView.image = UIImage(systemName: viewModel.isWatched ? "eye.fill" : "eye")
        didTapWatchedButton = onTapWatchedButton
    }
}

// MARK: - UI Setup
extension SeriesListTableViewCell {
    
    private func setupUI() {
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(episodeLabel)
        self.contentView.addSubview(descriptionLabel)
        self.contentView.addSubview(previewImageView)
        self.contentView.addSubview(watchedImageView)
        
        NSLayoutConstraint.activate([
            watchedImageView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -15),
            watchedImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10),
            watchedImageView.widthAnchor.constraint(equalToConstant: 29),
            watchedImageView.heightAnchor.constraint(equalToConstant: 23)
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 15),
            titleLabel.trailingAnchor.constraint(equalTo: watchedImageView.trailingAnchor, constant: -15),
            titleLabel.topAnchor.constraint(equalTo: watchedImageView.topAnchor)
        ])
        
        NSLayoutConstraint.activate([
            episodeLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            episodeLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            episodeLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            descriptionLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: watchedImageView.trailingAnchor),
            descriptionLabel.topAnchor.constraint(equalTo: episodeLabel.bottomAnchor, constant: 10),
        ])
        
        NSLayoutConstraint.activate([
            previewImageView.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            previewImageView.trailingAnchor.constraint(equalTo: watchedImageView.trailingAnchor),
            previewImageView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 10),
            previewImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            previewImageView.heightAnchor.constraint(equalToConstant: 250)
        ])
    }
}
