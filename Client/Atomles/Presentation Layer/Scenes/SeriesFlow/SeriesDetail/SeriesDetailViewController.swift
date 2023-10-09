//
//  SeriesDetailViewController.swift
//  Atomles
//
//  Created by Ildar on 12.08.2022.
//

import UIKit
import WebKit

class SeriesDetailViewController: UIViewController {

    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        presenter?.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupNavigationBar()
    }
    
    // MARK: - Properties
    var presenter: SeriesDetailPresenterProtocol?
    
    let webView: WKWebView = {
        let webView = WKWebView()
        webView.translatesAutoresizingMaskIntoConstraints = false
        return webView
    }()
}

// MARK: - View Protocol
extension SeriesDetailViewController: SeriesDetailViewProtocol {
    
    func loadInWebView(_ request: URLRequest) {
        self.webView.load(request)
    }
    
    func setupNavigationItem(with title: String) {
        self.navigationItem.title = title
    }
}

// MARK: - UI Setup
extension SeriesDetailViewController {
    
    private func setupUI() {
        self.view.backgroundColor = .systemBackground
        
        self.view.addSubview(webView)
        
        NSLayoutConstraint.activate([
            webView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            webView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            webView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }
    
    private func setupNavigationBar() {
        self.navigationController?.navigationBar.prefersLargeTitles = false
    }
}
