//
//  User.swift
//  PersonContact
//
//  Created by Saqib Siddique on 2022-08-19.
//

import Foundation

struct User: Codable, Identifiable {
    enum CodingKeys: CodingKey {
        case id
        case firstName
        case lastName
       // case email
        //case phone
    }    
    var id : String
    var firstName: String
    var lastName: String
   // var email: String
    //var phone: String
}
