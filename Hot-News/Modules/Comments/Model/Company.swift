//
//  Company.swift
//  Hot-News
//
//  Created by Apple on 9/07/22.
//

import Foundation
import ObjectMapper

struct Company: Mappable {
    var name: String = ""
    var catchPhrase: String = ""
    var bs: String = ""
    
    init() {}
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
       name <- map ["name"]
       catchPhrase <- map ["catchPhrase"]
       bs <- map ["name"]
    }
    
}

