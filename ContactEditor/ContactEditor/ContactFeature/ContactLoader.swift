//
//  ContactLoader.swift
//  ContactEditor
//
//  Created by Thiago Lourin on 07/03/23.
//

import Combine
import Foundation

protocol ContactLoader {
    func load() -> AnyPublisher<[ContactItem], Error>
}

final class ContactFileLoader: ContactLoader {
    
    private let fileLoader: FileLoader
    
    init(fileLoader: FileLoader) {
        self.fileLoader = fileLoader
    }
    
    func load() -> AnyPublisher<[ContactItem], Error> {
        return Future { promise in
            do {
                let loadedContent = try self.fileLoader.load()
                let contacts = loadedContent.compactMap { row -> ContactItem? in
                    if row.isEmpty { return nil }
                    
                    return ContactItem(id: UUID(),
                                       firstName: row[0],
                                       lastName: row[1],
                                       companyName: row[2],
                                       address: row[3],
                                       city: row[4],
                                       country: row[5],
                                       state: row[6],
                                       zip: row[7],
                                       phone1: row[8],
                                       phone: row[9],
                                       email: row[10])
                }
                promise(.success(contacts))
            } catch let error {
                promise(.failure(error))
            }
        }.eraseToAnyPublisher()
    }
}
