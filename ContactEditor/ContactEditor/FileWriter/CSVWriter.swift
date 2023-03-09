//
//  CSVWriter.swift
//  ContactEditor
//
//  Created by Thiago Lourin on 08/03/23.
//

import Foundation

let contactHeader = "first_name,last_name,company_name,address,city,county,state,zip,phone1,phone,email\n"

protocol FileWriter {
    func write(content: [[String]]) throws
    var bundle: Bundle? { get set }
}

final class CSVWriter: FileWriter {
    
    private let fileName: String
    
    var bundle: Bundle? = Bundle.main
    
    init(fileName: String) {
        self.fileName = fileName
    }
    
    func write(content: [[String]]) throws {
        do {
            guard let filePath = bundle?.path(forResource: fileName, ofType: "csv") else {
                throw CSVFileError.invalidFilePath
            }
            let csvContent = contactHeader.appending(content.map( {row in
                row.joined(separator: ",")
            } ).joined(separator: "\n"))
            
            try csvContent.write(toFile: filePath, atomically: true, encoding: .utf8)
        } catch {
            throw error
        }
    }
}
