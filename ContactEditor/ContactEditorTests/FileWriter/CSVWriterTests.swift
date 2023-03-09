//
//  CSVWriterTests.swift
//  ContactEditorTests
//
//  Created by Thiago Lourin on 09/03/23.
//

import XCTest
@testable import ContactEditor

final class CSVWriterTests: XCTestCase {

    private let testContactsFile = "test_contacts"
    
    func testSaveFile_withoutChanges_doesNotChangesContent() {
        let csvLoader = CSVLoader(fileName: testContactsFile)
        csvLoader.bundle = Bundle(for: type(of: self))
        let content = try! csvLoader.load()
        
        let sut = CSVWriter(fileName: testContactsFile)
        sut.bundle = Bundle(for: type(of: self))
        do {
            try sut.write(content: content)
        } catch {
            XCTFail("File writing should not raise an exception")
        }
        
        let newContent = try! csvLoader.load()
        
        XCTAssertEqual(content, newContent)
    }
    
    func testSaveFile_withChanges_changesContent() {
        let csvLoader = CSVLoader(fileName: testContactsFile)
        csvLoader.bundle = Bundle(for: type(of: self))
        let originalContent = try! csvLoader.load()
        var changedContent = originalContent
        
        let sut = CSVWriter(fileName: testContactsFile)
        sut.bundle = Bundle(for: type(of: self))
        
        changedContent[0][1] = "newThing"
        
        do {
            try sut.write(content: changedContent)
        } catch {
            XCTFail("File writing should not raise an exception")
        }
        
        let newContent = try! csvLoader.load()
        
        XCTAssertNotEqual(originalContent, newContent)
    }

}
