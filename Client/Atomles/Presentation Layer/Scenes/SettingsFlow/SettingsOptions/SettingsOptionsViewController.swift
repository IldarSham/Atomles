//
//  SettingsOptionsViewController.swift
//  Atomles
//
//  Created by Ildar Shamsullin on 17.03.2023.
//

import UIKit

class SettingsOptionsViewController: UIViewController {
    
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
    var presenter: SettingsOptionsPresenterProtocol!

    private(set) lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.register(
            SettingsOptionsTableViewCell.self,
            forCellReuseIdentifier: SettingsOptionsTableViewCell.reuseIdentifier
        )
        return tableView
    }()
}

// MARK: - UITableView Delegate & Data Source
extension SettingsOptionsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SettingsOptionsTableViewCell.reuseIdentifier, for: indexPath) as! SettingsOptionsTableViewCell
        
        let viewModel = presenter.getSettingsOptionsCellModel(index: indexPath.row)
        cell.configure(viewModel)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didSelectRowAt(index: indexPath.row)
    }
}

// MARK: - View Protocol
extension SettingsOptionsViewController: SettingsOptionsViewProtocol {
    
    func setupNavigationItem(with title: String) {
        self.navigationItem.title = title
    }
}

// MARK: - UI Setup
extension SettingsOptionsViewController {
    
    private func setupUI() {
        self.view.backgroundColor = .systemBackground
        
        self.view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.widthAnchor.constraint(equalTo: self.view.widthAnchor),
            tableView.heightAnchor.constraint(equalTo: self.view.heightAnchor)
        ])
    }
    
    private func setupNavigationBar() {
        self.navigationController?.navigationBar.prefersLargeTitles = false
    }
}
