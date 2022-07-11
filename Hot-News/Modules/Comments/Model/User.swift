//
//  User.swift
//  Hot-News
//
//  Created by Apple on 9/07/22.
//

import Foundation
import ObjectMapper

struct User: Mappable {
    var id: Int = 0
    var name: String = ""
    var userName: String = ""
    var email: String = ""
    var address: String = ""
    var phone: String = ""
    var website: String = ""
    var company: Company = Company()
    
    init() {}
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        id <- map ["id"]
        name <- map ["name"]
        userName <- map ["username"]
        email <- map ["email"]
        address <- map ["address"]
        phone <- map ["phone"]
        website <- map ["website"]
        company <- map ["company"]
    }
    
}
