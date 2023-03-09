//
//  ContactListTableViewControllerTests.swift
//  ContactEditorTests
//
//  Created by Thiago Lourin on 08/03/23.
//

import XCTest
@testable import ContactEditor

final class ContactListTableViewControllerTests: XCTestCase {

    func test_onInit_doesNotLoadCells() {
        let sut = makeSUT()
        sut.loadViewIfNeeded()
        
        XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0), 0)
    }
    
    func test_onViewWillAppear_loadsOneCell() {
        let sut = makeSUT()
        sut.loadViewIfNeeded()
        sut.beginAppearanceTransition(true, animated: false)
        
        XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0), 1)
    }
    
    private func makeSUT() -> ContactListTableViewController {
        let contactPresenterMock = ContactListPresenterMock()
        let sut = ContactListTableViewController(presenter: contactPresenterMock)
        contactPresenterMock.view = sut
        
        return sut
    }
}

final class ContactListPresenterMock: ContactListPresenterProtocol {
    var view: ContactListView?
    
    func loadContacts() {
        view?.onLoadContacts([ContactItem(id: UUID(), firstName: "Thiago", lastName: "Lourin", companyName: "Lourin", address: "Avenue", city: "Maringa", country: "Brazil", state: "Parana", zip: "87020015", phone1: "+5544991364849", phone: "+5544991364849", email: "lourintp@gmail.com")])
    }
}
