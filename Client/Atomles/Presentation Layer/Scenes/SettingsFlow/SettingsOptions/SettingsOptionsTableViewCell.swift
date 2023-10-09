//
//  SettingsOptionsTableViewCell.swift
//  Atomles
//
//  Created by Ildar Shamsullin on 17.03.2023.
//

import UIKit

struct SettingsOptionsCellModel {
    let optionText: String
    let isSelected: Bool
}

class SettingsOptionsTableViewCell: UITableViewCell {
    
    // MARK: - Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Properties
    private let optionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
}

// MARK: - Public methods
extension SettingsOptionsTableViewCell {

    func configure(_ viewModel: SettingsOptionsCellModel) {
        optionLabel.text = viewModel.optionText
        if viewModel.isSelected {
            self.accessoryType = .checkmark
        }
    }
}

extension SettingsOptionsTableViewCell {
    
    func setupUI() {
        self.contentView.addSubview(optionLabel)
        
        NSLayoutConstraint.activate([
            optionLabel.leftAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.leftAnchor),
            optionLabel.rightAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.rightAnchor),
            optionLabel.topAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.topAnchor),
            optionLabel.bottomAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.bottomAnchor)
        ])
    }
}
