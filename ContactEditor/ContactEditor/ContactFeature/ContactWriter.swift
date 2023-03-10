//
//  ContactWriter.swift
//  ContactEditor
//
//  Created by Thiago Lourin on 08/03/23.
//

import Foundation

protocol ContactWriter {
    func save(contacts: [ContactItem], editedContact: ContactItem)
}

final class ContactFileWriter: ContactWriter {
    
    private let fileLoader: FileLoader
    
    init(fileLoader: FileLoader) {
        self.fileLoader = fileLoader
    }
    
    // TODO: bad smell here, need to improve this logic
    func save(contacts: [ContactItem], editedContact: ContactItem) {
        
        var editingList = contacts
        
        for (index, each) in contacts.enumerated() {
            if each.id == editedContact.id {
                editingList[index] = editedContact
                break
            }
        }
                
        do {
            try CSVWriter(fileName: "sample_contacts").write(content: ContactToCSVMapper.map(contacts: editingList))
        } catch {
            print(error)
        }
    }
}

final class ContactToCSVMapper {
    static func map(contacts: [ContactItem]) -> [[String]] {
        var csvString = ""
        for contact in contacts {
            let row = "\(contact.firstName),\(contact.lastName),\(contact.companyName),\(contact.address),\(contact.city),\(contact.country),\(contact.state),\(contact.zip),\(contact.phone1),\(contact.phone),\(contact.email)\n"
            csvString += row
        }
        let rows = csvString.components(separatedBy: .newlines)
            .filter( {!$0.isEmpty} )
            .map( { $0.components(separatedBy: ",")} )
        
        return rows
    }
}


