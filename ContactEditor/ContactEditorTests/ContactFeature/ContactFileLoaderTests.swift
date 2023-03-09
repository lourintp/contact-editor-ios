//
//  ContactFileLoaderTests.swift
//  ContactEditorTests
//
//  Created by Thiago Lourin on 07/03/23.
//

import XCTest
@testable import ContactEditor

class ContactFileLoaderTests: XCTestCase {

    func test_init_doesNotLoadsFile() {
        let fileLoaderStub = FileLoaderStub()
        _ = makeSUT()
        
        XCTAssertEqual(fileLoaderStub.loadCallCount, 0)
    }
    
    func test_callLoadOnce_increasesCallCount() {
        let (fileLoaderStub, sut) = makeSUT()
        _ = sut.load()
        
        XCTAssertEqual(fileLoaderStub.loadCallCount, 1)
    }
    
    func test_callLoadForEmptyFile_returnsNoContacts() {
        let fileLoader = CSVLoader(fileName: "empty_file")
        fileLoader.bundle = Bundle(for: type(of: self))
        
        let sut = ContactFileLoader(fileLoader: fileLoader)
        _ = sut.load()
            .sink { _ in } receiveValue: { contactItems in
                XCTAssertTrue(contactItems.isEmpty)
        }
    }
    
    func test_callLoadForValidFile_returnsContacts() {
        let fileLoader = CSVLoader(fileName: "test_contacts")
        fileLoader.bundle = Bundle(for: type(of: self))
        
        let sut = ContactFileLoader(fileLoader: fileLoader)
        _ = sut.load()
            .sink { _ in } receiveValue: { contactItems in
                XCTAssertEqual(contactItems.count, 3, "Test should have three contacts")
        }
    }
    
    private func makeSUT() -> (FileLoaderStub, ContactFileLoader) {
        let fileLoaderStub = FileLoaderStub()
        let sut = ContactFileLoader(fileLoader: fileLoaderStub)
        
        return (fileLoaderStub, sut)
    }
}

final class FileLoaderStub: FileLoader {
    var bundle: Bundle?
    var loadCallCount = 0
    
    func load() throws -> [[String]] {
        loadCallCount += 1
        return [[]]
    }
}
