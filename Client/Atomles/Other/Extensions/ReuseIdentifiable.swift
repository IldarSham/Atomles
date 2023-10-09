//
//  ReuseIdentifiable.swift
//  Atomles
//
//  Created by Ildar on 25.07.2022.
//

import UIKit

protocol ReuseIdentifiable: AnyObject {
    static var reuseIdentifier: String { get }
}

extension ReuseIdentifiable {
    static var reuseIdentifier: String { .init(describing: self) }
}

extension UICollectionViewCell: ReuseIdentifiable {}
extension UITableViewCell: ReuseIdentifiable {}
