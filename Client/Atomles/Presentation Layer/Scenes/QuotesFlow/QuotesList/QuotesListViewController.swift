//
//  QuotesListViewController.swift
//  Atomles
//
//  Created by Ildar Shamsullin on 15.11.2022.
//

import UIKit

class QuotesListViewController: UIPageViewController {
    
    // MARK: - Initialization
    init() {
        super.init(transitionStyle: .scroll, navigationOrientation: .vertical, options: nil)
        self.dataSource = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
    var presenter: QuotesListPresenterProtocol!
    var imageClient: ImageClientProtocol!
    
    private func getPageViewController(for index: Int) -> QuoteViewController? {
        if index < 0 || index >= presenter.numberOfQuotes {
            return nil
        }
        
        let vc = QuoteViewController(pageIndex: index)
        
        let viewModel = presenter.getQuoteViewModel(for: index)
        vc.configure(viewModel)
        
        imageClient.setImage(on: vc.imageView, fromURL: viewModel.characterImageUrl)
                
        return vc
    }
}

// MARK: - View Protocol
extension QuotesListViewController: QuotesListViewProtocol {
    
    func onFetchQuotesSuccess() {
        guard let vc = getPageViewController(for: 0) else { return }
        setViewControllers([vc], direction: .forward, animated: false)
    }
    
    func onFetchQuotesFailure(error: Error) {
        print(error)
    }
}

extension QuotesListViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if let currentVC = viewController as? QuoteViewController {
            let currentIndex = currentVC.pageIndex
            return getPageViewController(for: currentIndex - 1)
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if let currentVC = viewController as? QuoteViewController {
            let currentIndex = currentVC.pageIndex
            return getPageViewController(for: currentIndex + 1)
        }
            
        return nil
    }
}

// MARK: - UI Setup
extension QuotesListViewController {
    
    private func setupUI() {
        self.view.backgroundColor = .systemBackground
    }
    
    private func setupNavigationBar() {
        self.navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    private func setupNavigationItem() {
        self.navigationItem.title = "Цитатник"
    }
}
