//
//  Coordinator.swift
//  Atomles
//
//  Created by Ildar on 09.06.2022.
//

import Foundation

protocol Coordinator {
    func start()
    func coordinate(to coordinator: Coordinator)
}

extension Coordinator {
    func coordinate(to coordinator: Coordinator) {
        coordinator.start()
    }
}
