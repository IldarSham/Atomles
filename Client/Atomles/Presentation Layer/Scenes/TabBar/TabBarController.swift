//
//  TabBarController.swift
//  Atomles
//
//  Created by Ildar on 09.06.2022.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 15.0, *) {
            let appearance = UITabBarAppearance()
            appearance.configureWithOpaqueBackground()
            self.tabBar.standardAppearance = appearance
            self.tabBar.scrollEdgeAppearance = appearance
        }
        
        self.tabBar.tintColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
    }
}

