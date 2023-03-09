//
//  ContactItem.swift
//  ContactEditor
//
//  Created by Thiago Lourin on 07/03/23.
//

import Foundation

struct ContactItem: Decodable {
    let id: UUID
    let firstName: String
    let lastName: String
    let companyName: String
    let address: String
    let city: String
    let country: String
    let state: String
    let zip: String
    let phone1: String
    let phone: String
    let email: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case companyName = "company_name"
        case address
        case city
        case country
        case state
        case zip
        case phone1
        case phone
        case email
    }
}
