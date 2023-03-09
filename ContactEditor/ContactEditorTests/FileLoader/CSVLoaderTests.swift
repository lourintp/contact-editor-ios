//
//  CSVLoaderTests.swift
//  ContactEditorTests
//
//  Created by Thiago Lourin on 08/03/23.
//

import XCTest
@testable import ContactEditor

final class CSVLoaderTests: XCTestCase {

    func test_loadWithInvalidPath_raiseException() {
        let sut = makeSUT(with: "invalidPath.csv")
        
        XCTAssertThrowsError(try sut.load(), "Load CSV with invalid path should raise an error.")
    }
    
    func test_loadWithValidPathAndEmptyFile_returnsEmptyList() {
        let sut = makeSUT(with: "empty_file")
        
        do {
            let list = try sut.load()
            XCTAssertTrue(list.isEmpty)
        } catch let error {
            XCTFail("Load valid CSV should not raise an error")
            XCTAssertEqual(error as! CSVFileError, CSVFileError.invalidFilePath)
        }
    }
    
    func test_loadValidFileWithContacts_returnsNotEmptyList() {
        let sut = makeSUT(with: "test_contacts")
        
        do {
            let list = try sut.load()
            XCTAssertEqual(list.count, 3)            
        } catch {
            XCTFail("Load valid CSV should not raise an error")
        }
    }
    
    private func makeSUT(with fileName: String) -> CSVLoader {
        let bundle = Bundle(for: type(of: self))
        let sut = CSVLoader(fileName: fileName)
        sut.bundle = bundle
        trackForMemoryLeaks(sut)
                
        return sut
    }
}
