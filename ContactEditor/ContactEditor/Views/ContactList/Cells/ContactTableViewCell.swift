//
//  ContactTableViewCell.swift
//  ContactEditor
//
//  Created by Thiago Lourin on 08/03/23.
//

import UIKit

class ContactTableViewCell: UITableViewCell {
    
    @IBOutlet private var labelName: UILabel!
    
    func setup(contact: ContactItem) {
        labelName.text = contact.firstName.appending(" ").appending(contact.lastName)
    }
}
