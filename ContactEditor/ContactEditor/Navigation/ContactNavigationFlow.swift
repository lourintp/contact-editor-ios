//
//  ContactNavigationFlow.swift
//  ContactEditor
//
//  Created by Thiago Lourin on 10/03/23.
//

import UIKit

final class ContactFlow {
    private let navigationController: UINavigationController?    
    
    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    func start() {
        presentContactList()
    }
    
    private func presentContactList() {
        let presenter = ContactListPresenter()
        let vc = ContactListTableViewController(presenter: presenter)
        
        vc.onSelectContact = { (contactList, contact) in
            self.pushContactDetail(all: contactList, toEdit: contact)
        }
        
        navigationController?.show(vc, sender: self)
    }
    
    private func pushContactDetail(all: [ContactItem], toEdit: ContactItem) {
        let vc = ContactDetailViewController(all: all, contact: toEdit)
        vc.onSaveContact = {
            self.navigationController?.popToRootViewController(animated: true)
        }        
        navigationController?.pushViewController(vc, animated: true)
    }
}
