//
//  CharacterDetailViewController.swift
//  Atomles
//
//  Created by Ildar Shamsullin on 07.11.2022.
//

import UIKit

class CharacterDetailViewController: UIViewController {
    
    enum TableSection: Int, CaseIterable {
        case gallery
        case description
    }
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        presenter.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupNavigationBar()
    }
    
    // MARK: - Properties
    var presenter: CharacterDetailPresenterProtocol!
    var imageClient: ImageClientProtocol!
    
    private(set) lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.allowsSelection = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
}

extension CharacterDetailViewController: CharacterDetailViewProtocol {
    
    func setNavigationTitle(title: String) {
        self.navigationItem.title = title
    }
    
    func onFetchCharacterDetailSuccess() {
        tableView.reloadData()
    }
    
    func onFetchCharacterDetailFailure(error: Error) {
        print(error)
    }
}

// MARK: - UITableView Delegate & Data Source
extension CharacterDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return TableSection.allCases.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let tableSection = TableSection(rawValue: section) else { return nil }
        
        switch tableSection {
        case .gallery:
            return "Галерея"
        case .description:
            return "Описание"
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let tableSection = TableSection(rawValue: indexPath.section) else { return UITableViewCell() }
        
        switch tableSection {
        case .gallery:
            guard let viewModel = presenter.getGalleryCellModel() else {
                return UITableViewCell()
            }
            return GalleryTableViewCell(viewModel: viewModel, imageClient: imageClient)
        case .description:
            let cell = DescriptionTableViewCell()
            if let viewModel = presenter.getDescriptionCellModel() {
                cell.configure(viewModel)
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let tableSection = TableSection(rawValue: indexPath.section) else { return 0.0 }
        
        switch tableSection {
        case .gallery:
            return Constants.galleryCellHeight
        case .description:
            return UITableView.automaticDimension
        }
    }
}

// MARK: - UI Setup
extension CharacterDetailViewController {
    
    private func setupUI() {
        self.view.backgroundColor = .systemBackground
        
        self.view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.widthAnchor.constraint(equalTo: self.view.widthAnchor),
            tableView.heightAnchor.constraint(equalTo: self.view.heightAnchor)
        ])
    }
    
    private func setupNavigationBar() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
}

// MARK: - Constants
extension CharacterDetailViewController {
    
    private enum Constants {
        static let galleryCellHeight: CGFloat = 400.0
    }
}
