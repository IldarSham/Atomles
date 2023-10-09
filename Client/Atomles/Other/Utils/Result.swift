//
//  Result.swift
//  Atomles
//
//  Created by Ildar on 10.10.2022.
//

import Foundation

enum Result<T> {
    case success(T)
    case failure(Error)
}
