//
//  SettingsViewController.swift
//  Atomles
//
//  Created by Ildar Shamsullin on 01.02.2023.
//

import UIKit

class SettingsViewController: UIViewController {
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupNavigationItem()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupNavigationBar()
    }
    
    // MARK: - Properties
    var presenter: SettingsPresenterProtocol!
    
    private(set) lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.register(
            SettingsTableViewCell.self,
            forCellReuseIdentifier: SettingsTableViewCell.reuseIdentifier
        )
        return tableView
    }()
}

// MARK: - View Protocol
extension SettingsViewController: SettingsViewProtocol {
    
    func reloadData() {
        tableView.reloadData()
    }
    
    func setAppTheme(_ theme: AppTheme) {
        let scenes = UIApplication.shared.connectedScenes
        let windowScenes = scenes.first as? UIWindowScene
        let window = windowScenes?.windows.first
        window?.overrideUserInterfaceStyle = theme.getUserInterfaceStyle()
    }
}

// MARK: - UITableView Delegate & Data Source
extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SettingsTableViewCell.reuseIdentifier, for: indexPath) as! SettingsTableViewCell
        
        let viewModel = presenter.getSettingsCellModel(for: indexPath.row)
        cell.configure(viewModel)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presenter.didSelectRowAt(index: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 43.5
    }
}

// MARK: - UI Setup
extension SettingsViewController {
    
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
    
    private func setupNavigationItem() {
        self.navigationItem.title = "Настройки"
    }
}
