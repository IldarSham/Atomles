//
//  LoadingTableViewCell.swift
//  Atomles
//
//  Created by Ildar on 13.06.2022.
//

import UIKit

class LoadingTableViewCell: UITableViewCell {

    // MARK: - Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Properties
    lazy var titleLabel = getConfiguredEmptyView(radius: 6)
    lazy var subtitleLabel = getConfiguredEmptyView(radius: 6)
    lazy var descriptionLabel = getConfiguredEmptyView(radius: 6)
    lazy var previewImageView = getConfiguredEmptyView(radius: 0)
    
    // MARK: - Methods
    private func getConfiguredEmptyView(radius: CGFloat) -> UIView {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.2431372549, green: 0.3607843137, blue: 0.5019607843, alpha: 1).withAlphaComponent(0.3)
        view.layer.cornerRadius = radius
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
}

// MARK: - UI Setup
extension LoadingTableViewCell {
    
    private func setupUI() {
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(subtitleLabel)
        self.contentView.addSubview(descriptionLabel)
        self.contentView.addSubview(previewImageView)
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 15),
            titleLabel.widthAnchor.constraint(equalTo: self.contentView.widthAnchor, multiplier: 1/2),
            titleLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10),
            titleLabel.heightAnchor.constraint(equalToConstant: 12)
        ])
        
        NSLayoutConstraint.activate([
            subtitleLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            subtitleLabel.widthAnchor.constraint(equalTo: titleLabel.widthAnchor, multiplier: 1/2),
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            subtitleLabel.heightAnchor.constraint(equalToConstant: 12)
        ])
        
        NSLayoutConstraint.activate([
            descriptionLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -15),
            descriptionLabel.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 10),
            descriptionLabel.heightAnchor.constraint(equalToConstant: 12)
        ])
        
        NSLayoutConstraint.activate([
            previewImageView.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            previewImageView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -15),
            previewImageView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 10),
            previewImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            previewImageView.heightAnchor.constraint(equalToConstant: 250).withPriority(999),
        ])
    }
}
