//
//  ContactListTableViewController.swift
//  ContactEditor
//
//  Created by Thiago Lourin on 08/03/23.
//

import UIKit

class ContactListTableViewController: UITableViewController {
    
    private var data = [ContactItem]()
    private var presenter: ContactListPresenterProtocol?
    
    init(presenter: ContactListPresenterProtocol) {
        self.presenter = presenter
        
        super.init(style: .plain)
        self.presenter?.view = self
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Contacts"
        
        tableView.register(UINib(nibName: String(describing: ContactTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: ContactTableViewCell.self))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
                
        presenter?.loadContacts()
    }

    // MARK: - Table view data source    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ContactTableViewCell = tableView.dequeueReusableCell()
        cell.setup(contact: data[indexPath.row])
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let vc = ContactDetailViewController(contact: data[indexPath.row])
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension ContactListTableViewController: ContactListView {
    func onLoadContacts(_ items: [ContactItem]) {
        self.data = items.sorted(by: { $0.firstName < $1.firstName })
        tableView.reloadData()
    }
}
