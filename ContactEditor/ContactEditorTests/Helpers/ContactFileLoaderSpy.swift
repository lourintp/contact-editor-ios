//
//  ContactFileLoaderSpy.swift
//  ContactEditorTests
//
//  Created by Thiago Lourin on 09/03/23.
//

import Combine
@testable import ContactEditor

final class ContactFileLoaderSpy: ContactLoader {
    func load() -> AnyPublisher<[ContactItem], Error> {
        return Future { promise in
            promise(.success([]))
        }.eraseToAnyPublisher()
    }
}
