//
//  SettingsCell.swift
//  Atomles
//
//  Created by Ildar Shamsullin on 12.02.2023.
//

import UIKit

struct SettingsCellModel {
    enum CellType {
        case stringValue(value: String)
        case switchValue(value: Bool)
    }
    let title: String
    let type: CellType
    let selection: Bool
}

class SettingsTableViewCell: UITableViewCell {
    
    // MARK: - Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        clearStackView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Properties
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .center
        stack.spacing = 10
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Methods
    private func clearStackView() {
        guard let subview = stackView.arrangedSubviews.last else { return }
        stackView.removeArrangedSubview(subview)
        subview.removeFromSuperview()
    }
    
    private func createOptionLabel(withText text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = .systemGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    private func createToggle(isOn: Bool) -> UISwitch {
        let toggle = UISwitch()
        toggle.isOn = isOn
        toggle.translatesAutoresizingMaskIntoConstraints = false
        return toggle
    }
}

// MARK: - Public methods
extension SettingsTableViewCell {
    
    func configure(_ viewModel: SettingsCellModel) {
        titleLabel.text = viewModel.title
        
        switch viewModel.type {
        case .stringValue(let value):
            let label = createOptionLabel(withText: value)
            stackView.addArrangedSubview(label)
        case .switchValue(let value):
            let toggle = createToggle(isOn: value)
            stackView.addArrangedSubview(toggle)
        }

        if viewModel.selection {
            self.accessoryType = .disclosureIndicator
        }
    }
}

// MARK: - UI Setup
extension SettingsTableViewCell {
    
    private func setupUI() {
        self.contentView.addSubview(stackView)
        stackView.addArrangedSubview(titleLabel)
            
        NSLayoutConstraint.activate([
            stackView.leftAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.leftAnchor),
            stackView.rightAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.rightAnchor),
            stackView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor)
        ])
    }
}
