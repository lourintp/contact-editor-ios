//
//  ContactListPresenter.swift
//  ContactEditor
//
//  Created by Thiago Lourin on 09/03/23.
//

import Combine
import Foundation

protocol ContactListPresenterProtocol {
    func loadContacts()
    
    var view: ContactListView? { get set }
}

protocol ContactListView: AnyObject {
    func onLoadContacts(_ items: [ContactItem])
}

final class ContactListPresenter: ContactListPresenterProtocol {
    
    private var cancellables = Set<AnyCancellable>()
    private let loader: ContactLoader
    weak var view: ContactListView?
    
    init(loader: ContactLoader) {
        self.loader = loader
    }
    
    func loadContacts() {
        loader.load()
            .receive(on: DispatchQueue.main)
            .sink { result in
        } receiveValue: { items in
            self.view?.onLoadContacts(items)
        }.store(in: &cancellables)
    }
}
