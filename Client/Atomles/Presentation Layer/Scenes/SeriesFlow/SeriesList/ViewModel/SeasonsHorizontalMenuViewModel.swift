//
//  SeasonsHorizontalMenuViewModel.swift
//  Atomles
//
//  Created by Ildar on 18.10.2022.
//

import Foundation

enum SeasonsHorizontalMenuViewModel: Int {
    case season1
    case season2
    
    init?(season: Int) {
        switch season {
        case 1:
            self = .season1
        case 2:
            self = .season2
        default:
            return nil
        }
    }
}

extension SeasonsHorizontalMenuViewModel {
    
    var title: String {
        switch self {
        case .season1:
            return "Сезон 1"
        case .season2:
            return "Сезон 2"
        }
    }
}
