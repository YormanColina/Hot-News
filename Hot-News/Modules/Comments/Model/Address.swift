//
//  Address.swift
//  Hot-News
//
//  Created by Apple on 9/07/22.
//

import Foundation
import ObjectMapper

struct Address: Mappable {
    var street: String = ""
    var suite: String = ""
    var city: String = ""
    var zipcode: String = ""
    
    init(){}
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        street <- map ["street"]
        suite <- map ["suite"]
        city  <- map ["city"]
        zipcode <- map ["zipcode"]
    }

}
