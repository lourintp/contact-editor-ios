//
//  ContactNavigationFlow.swift
//  ContactEditor
//
//  Created by Thiago Lourin on 10/03/23.
//

import UIKit

final class ContactFlow {
    private let navigationController: UINavigationController?
    private let writer: ContactWriter
    private let loader: ContactLoader
    
    init(navigationController: UINavigationController?,
         writer: ContactWriter,
         loader: ContactLoader) {
        self.navigationController = navigationController
        self.writer = writer
        self.loader = loader
    }
    
    func start() {
        presentContactList()
    }
    
    private func presentContactList() {
        let presenter = ContactListPresenter(loader: loader)
        let vc = ContactListTableViewController(presenter: presenter)
        
        vc.onSelectContact = { (contactList, contact) in
            self.pushContactDetail(all: contactList, toEdit: contact)
        }
        
        navigationController?.show(vc, sender: self)
    }
    
    private func pushContactDetail(all: [ContactItem], toEdit: ContactItem) {
        let vc = ContactDetailViewController(writer: writer, all: all, contact: toEdit)
        vc.onSaveContact = {
            self.navigationController?.popToRootViewController(animated: true)
        }        
        navigationController?.pushViewController(vc, animated: true)
    }
}
