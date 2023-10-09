//
//  LoadingTableViewProvider.swift
//  Atomles
//
//  Created by Ildar on 11.06.2022.
//

import UIKit

class LoadingTableViewProvider: NSObject, TableViewProvider {
    
    let configuration: Configuration
    
    init(configuration: Configuration = Configuration()) {
        self.configuration = configuration
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return configuration.numberOfRowsInSection
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return configuration.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: LoadingTableViewCell.reuseIdentifier, for: indexPath) as! LoadingTableViewCell
    }
}

extension LoadingTableViewProvider {
    
    struct Configuration {
        let numberOfRowsInSection: Int
        let numberOfSections: Int
        
        init(numberOfRowsInSection: Int = 1, numberOfSections: Int = 10) {
            self.numberOfRowsInSection = numberOfRowsInSection
            self.numberOfSections = numberOfSections
        }
    }
}
