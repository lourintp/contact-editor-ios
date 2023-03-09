//
//  ContactFileWriterTests.swift
//  ContactEditorTests
//
//  Created by Thiago Lourin on 08/03/23.
//

import XCTest
@testable import ContactEditor

protocol ContactWriter {
    func save(uuid: UUID)
}

final class ContactFileWriter: ContactWriter {
    
    private let fileLoader: FileLoader
    
    init(fileLoader: FileLoader) {
        self.fileLoader = fileLoader
    }
    
    func save(uuid: UUID) {
        
    }
}

final class ContactFileWriterTests: XCTestCase {

    func test_saveContactEditing_savesChanges() {

    }
}
