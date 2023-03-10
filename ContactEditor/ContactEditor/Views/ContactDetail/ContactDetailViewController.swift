//
//  ContactDetailViewController.swift
//  ContactEditor
//
//  Created by Thiago Lourin on 09/03/23.
//

import Combine
import UIKit

class ContactDetailViewController: UIViewController {
    
    @IBOutlet weak var textFieldFirstName: UITextField!
    @IBOutlet weak var textFieldLastName: UITextField!
    @IBOutlet weak var textFieldCompanyName: UITextField!
    @IBOutlet weak var textFieldAddress: UITextField!
    @IBOutlet weak var textFieldCity: UITextField!
    @IBOutlet weak var textFieldCountry: UITextField!
    @IBOutlet weak var textFieldState: UITextField!
    @IBOutlet weak var textFieldZip: UITextField!
    @IBOutlet weak var textFieldPhone1: UITextField!
    @IBOutlet weak var textFieldPhone: UITextField!
    @IBOutlet weak var textFieldEmail: UITextField!
    
    @Published private var isEditingMode: Bool = false
    private var cancellable: AnyCancellable?
    
    private var contact: ContactItem
        
    init(contact: ContactItem) {
        self.contact = contact
        
        super.init(nibName: String(describing: ContactDetailViewController.self), bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = contact.firstName.appending(" ").appending(contact.lastName)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupUI()
        setupEditingObserver()
    }
    
    @objc private func didTapEdit() {
        debugPrint("Edit")
        updateEditingMode()
    }
    
    @objc private func didTapSave() {
        updateEditingMode()
        debugPrint("Save")
    }
    
    private func updateEditingMode() {
        isEditingMode = !isEditingMode
    }
    
    private func setupUI() {
        textFieldFirstName.text = contact.firstName
        textFieldLastName.text = contact.lastName
        textFieldCompanyName.text = contact.companyName
        textFieldAddress.text = contact.address
        textFieldCity.text = contact.city
        textFieldState.text = contact.state
        textFieldCountry.text = contact.country
        textFieldZip.text = contact.zip
        textFieldPhone1.text = contact.phone1
        textFieldPhone.text = contact.phone
        textFieldEmail.text = contact.email
    }
    
    private func setupEditingObserver() {
        cancellable = $isEditingMode.sink(receiveValue: { newValue in
            self.switchEditingMode(newValue)
        })
    }
    
    private func switchEditingMode(_ isEditing: Bool) {
        textFieldFirstName.isEnabled = isEditing
        textFieldLastName.isEnabled = isEditing
        textFieldCompanyName.isEnabled = isEditing
        textFieldAddress.isEnabled = isEditing
        textFieldCity.isEnabled = isEditing
        textFieldCountry.isEnabled = isEditing
        textFieldState.isEnabled = isEditing
        textFieldZip.isEnabled = isEditing
        textFieldPhone1.isEnabled = isEditing
        textFieldPhone.isEnabled = isEditing
        textFieldEmail.isEnabled = isEditing
        
        navigationItem.rightBarButtonItem = nil
        navigationItem.rightBarButtonItem = isEditing ? UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(didTapSave)) : UIBarButtonItem(title: "Edit", style: .done, target: self, action: #selector(didTapEdit))
    }
}
