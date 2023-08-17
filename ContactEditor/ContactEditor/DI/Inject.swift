//
//  Inject.swift
//  ContactEditor
//
//  Created by Thiago Lourin on 17/08/23.
//

import Foundation

@propertyWrapper
struct Inject<Value> {
    var wrappedValue: Value {
        Dependencies.root.resolve()
    }
}
