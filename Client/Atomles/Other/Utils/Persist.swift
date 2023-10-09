//
//  UserDefaultsFacade.swift
//  Atomles
//
//  Created by Ildar on 17.10.2022.
//

import Foundation

@propertyWrapper
struct Persist<T> {
    let key: String
    let defaultValue: T
    
    var wrappedValue: T {
        get { UserDefaults.standard.object(forKey: key) as? T ?? defaultValue }
        set { UserDefaults.standard.set(newValue, forKey: key) }
    }
}
