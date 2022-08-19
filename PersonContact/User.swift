//
//  User.swift
//  PersonContact
//
//  Created by Saqib Siddique on 2022-08-19.
//

import Foundation

struct User: Codable, Identifiable {
   
    let id : String
    let firstName: String
    let lastName: String
    let email: String?
    let phone: String?
}
