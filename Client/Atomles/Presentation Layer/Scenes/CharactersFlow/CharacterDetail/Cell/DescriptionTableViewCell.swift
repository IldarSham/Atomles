//
//  DescriptionTableViewCell.swift
//  Atomles
//
//  Created by Ildar Shamsullin on 07.11.2022.
//

import UIKit

struct DescriptionCellViewModel {
    let description: String
}

class DescriptionTableViewCell: UITableViewCell {

    // MARK: - Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Properties
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
}

// MARK: - Public methods
extension DescriptionTableViewCell {

    func configure(_ viewModel: DescriptionCellViewModel) {
        descriptionLabel.text = viewModel.description
    }
}

// MARK: - UI Setup
extension DescriptionTableViewCell {
    
    private func setupUI() {
        self.contentView.addSubview(descriptionLabel)
    
        NSLayoutConstraint.activate([
            descriptionLabel.leftAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.leftAnchor),
            descriptionLabel.rightAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.rightAnchor),
            descriptionLabel.topAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.topAnchor),
            descriptionLabel.bottomAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.bottomAnchor)
        ])
    }
}
