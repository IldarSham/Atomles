//
//  NSLayoutConstraint+Extension.swift
//  Atomles
//
//  Created by Ildar on 18.06.2022.
//

import UIKit

extension NSLayoutConstraint {
    
    func withPriority(_ priority: Float) -> NSLayoutConstraint {
        self.priority = UILayoutPriority(priority)
        return self
    }
}
