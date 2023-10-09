//
//  AppTheme.swift
//  Atomles
//
//  Created by Ildar Shamsullin on 19.03.2023.
//

import UIKit

enum AppTheme: Int, CaseIterable {
    case system
    case light
    case dark
    
    func getUserInterfaceStyle() -> UIUserInterfaceStyle {
        switch self {
        case .system:
            return .unspecified
        case .light:
            return .light
        case .dark:
            return .dark
        }
    }
}
