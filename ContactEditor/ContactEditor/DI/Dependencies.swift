//
//  Dependencies.swift
//  ContactEditor
//
//  Created by Thiago Lourin on 17/08/23.
//

import Foundation

final class Dependencies {
    static var root = Dependencies()
    
    private var factories = [String: () -> Any]()
    
    func add<T>(_ factory: @escaping () -> T) {
        let key = String(describing: T.self)
        factories[key] = factory
    }
    
    func resolve<T>() -> T {
        let key = String(describing: T.self)
        
        guard let component: T = factories[key]?() as? T else {
            fatalError("Dependency \(T.self) could not be resolved")
        }
        
        return component
    }
}
