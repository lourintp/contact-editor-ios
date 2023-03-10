//
//  ContactTableViewCell.swift
//  ContactEditor
//
//  Created by Thiago Lourin on 08/03/23.
//

import UIKit

class ContactTableViewCell: UITableViewCell {
    
    @IBOutlet private var labelName: UILabel!
    @IBOutlet private var labelCompany: UILabel!
    @IBOutlet private var labelPhone: UILabel!
    @IBOutlet private var labelEmail: UILabel!
    @IBOutlet private var labelCountry: UILabel!
    
    func setup(contact: ContactItem) {
        labelName.text = contact.firstName.appending(" ").appending(contact.lastName)
        labelCompany.text = contact.companyName
        labelPhone.text = contact.phone
        labelEmail.text = contact.email
        labelCountry.text = contact.city.appending(" - ").appending(contact.country)
    }
}
