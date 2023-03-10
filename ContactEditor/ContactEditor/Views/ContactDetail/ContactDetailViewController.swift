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
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @Published private var isEditingMode: Bool = false
    private var cancellable: AnyCancellable?
    
    private let writer: ContactWriter
    private let all: [ContactItem]
    private var contact: ContactItem
    
    var onSaveContact: (() -> Void)?
        
    init(writer: ContactWriter, all: [ContactItem], contact: ContactItem) {
        self.writer = writer
        self.all = all
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
        hideKeyboardWhenTappedAround()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(self)

    }
    
    @objc private func didTapEdit() {
        debugPrint("Edit")
        updateEditingMode()
    }
    
    @objc private func didTapSave() {
        // TODO: move this to a presenter
        
        updateEditingMode()
        debugPrint("Save")
        
        let editedContact = ContactItem(id: contact.id,
                                        firstName: textFieldFirstName.unwrappedText(),
                                        lastName: textFieldLastName.unwrappedText(),
                                        companyName: textFieldCompanyName.unwrappedText(),
                                        address: textFieldAddress.unwrappedText(),
                                        city: textFieldCity.unwrappedText(),
                                        country: textFieldCountry.unwrappedText(),
                                        state: textFieldState.unwrappedText(),
                                        zip: textFieldZip.unwrappedText(),
                                        phone1: textFieldPhone1.unwrappedText(),
                                        phone: textFieldPhone.unwrappedText(),
                                        email: textFieldEmail.unwrappedText())
                
        writer.save(contacts: all, editedContact: editedContact)
        
        onSaveContact?()
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

extension ContactDetailViewController {
    @objc func keyboardWillShow(notification: NSNotification){
        let userInfo = notification.userInfo!
        var keyboardFrame: CGRect = (userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        keyboardFrame = self.view.convert(keyboardFrame, from: nil)

        var contentInset: UIEdgeInsets = scrollView.contentInset
        contentInset.bottom = keyboardFrame.size.height
        scrollView.contentInset = contentInset
    }

    @objc func keyboardWillHide(notification: NSNotification){
        let contentInset: UIEdgeInsets = UIEdgeInsets.zero
        scrollView.contentInset = contentInset
    }
}
