//
//  SeriesListViewController.swift
//  Atomles
//
//  Created by Ildar on 09.06.2022.
//

import UIKit

class SeriesListViewController: UIViewController {

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupNavigationItem()
                
        presenter.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupNavigationBar()
    }
    
    // MARK: - Properties
    var presenter: SeriesListPresenterProtocol!
    var imageClient: ImageClientProtocol!
    
    private var previousIndex: Int?
    
    private(set) lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.tableHeaderView = .init(frame: .init(x: 0, y: 0, width: 0, height: 10))
        tableView.tableFooterView = .init(frame: .init(x: 0, y: 0, width: 0, height: CGFloat.leastNonzeroMagnitude))
        tableView.sectionHeaderHeight = 0
        tableView.sectionFooterHeight = 10
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.register(
            LoadingTableViewCell.self,
            forCellReuseIdentifier: LoadingTableViewCell.reuseIdentifier
        )
        
        tableView.register(
            SeriesListTableViewCell.self,
            forCellReuseIdentifier: SeriesListTableViewCell.reuseIdentifier
        )
        
        return tableView
    }()
    
    private(set) lazy var horizontalMenuView: HorizontalMenuView = {
        let view = HorizontalMenuView(items: [
            SeasonsHorizontalMenuViewModel.season1.title,
            SeasonsHorizontalMenuViewModel.season2.title
        ])
        view.delegate = self
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
        
    // MARK: - Public Methods
    func scrollToRow(_ section: Int) {
        previousIndex = section
        tableView.scrollToRow(at: IndexPath(row: 0, section: section), at: .top, animated: true)
    }
}

// MARK: - UITableView Delegate & Data Source
extension SeriesListViewController: TableViewProvider {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return presenter.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SeriesListTableViewCell.reuseIdentifier, for: indexPath) as! SeriesListTableViewCell
        
        let viewModel = presenter.getCellModel(for: indexPath.section)
        cell.configure(
            viewModel: viewModel,
            onTapWatchedButton: { [unowned self] in
                presenter.handleWatchedButtonTap(at: indexPath.section)
            }
        )
        
        imageClient.setImage(on: cell.previewImageView, fromURL: viewModel.previewImageUrl)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presenter.didSelectRow(at: indexPath.section)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.isDragging {
            guard let indexPath = tableView.indexPathForRow(at: CGPoint(x: 0, y: scrollView.contentOffset.y)) else {
                return
            }
            
            if indexPath.section != previousIndex {
                previousIndex = indexPath.section
                
                if let item = presenter.menuItemForSectionIndex(indexPath.section) {
                    horizontalMenuView.selectItem(at: item.rawValue)
                }
            }
        }
    }
}

// MARK: - View Protocol
extension SeriesListViewController: SeriesListViewProtocol {

    func onFetchSeriesListSuccess() {
        setTableViewProvider(self)
        reloadData()
    }
    
    func onFetchSeriesListFailure(_ error: Error) {
        print(error)
    }
    
    func reloadData() {
        tableView.reloadData()
    }
    
    func reloadSections(_ sections: IndexSet) {
        tableView.reloadSections(sections, with: .none)
    }
    
    func setTableViewProvider(_ provider: TableViewProvider) {
        tableView.delegate = provider
        tableView.dataSource = provider
    }
}

// MARK: - HorizontalMenuView Delegate
extension SeriesListViewController: HorizontalMenuViewDelegate {
    
    func didSelectItem(at index: Int) {
        guard let item = SeasonsHorizontalMenuViewModel(rawValue: index) else { return }
        
        if let index = presenter.sectionIndexForMenuItem(item) {
            scrollToRow(index)
        }
    }
}

// MARK: - UI Setup
extension SeriesListViewController {
    
    private func setupUI() {
        self.view.backgroundColor = .systemBackground
        
        self.view.addSubview(horizontalMenuView)
        self.view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            horizontalMenuView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            horizontalMenuView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            horizontalMenuView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            horizontalMenuView.heightAnchor.constraint(equalToConstant: 28.0)
        ])
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: horizontalMenuView.bottomAnchor, constant: 10),
            tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }
    
    private func setupNavigationBar() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func setupNavigationItem() {
        self.navigationItem.title = "Серии"
    }
}
