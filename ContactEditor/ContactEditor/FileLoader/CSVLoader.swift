//
//  CSVLoader.swift
//  ContactEditor
//
//  Created by Thiago Lourin on 08/03/23.
//

import Foundation

enum CSVFileError: Error {
    case invalidFilePath
}

protocol FileLoader {
    func load() throws -> [[String]]
    
    var bundle: Bundle? { get set }
}

final class CSVLoader: FileLoader {
        
    private let fileName: String
    
    var bundle: Bundle? = Bundle.main
    
    init(fileName: String) {
        self.fileName = fileName
    }
    
    func load() throws -> [[String]] {
        do {
            guard let filePath = bundle?.path(forResource: fileName, ofType: "csv") else {
                throw CSVFileError.invalidFilePath
            }
            
            let content = try String(contentsOfFile: filePath)
            var rows = content.components(separatedBy: .newlines)
                .filter( {!$0.isEmpty} )
                .map( { $0.components(separatedBy: ",")} )
            if rows.isEmpty {
                return []
            }
            
            rows.removeFirst()
            
            return rows
        } catch {
            throw error
        }
    }
}
