//
//  Location.swift
//  Hot-News
//
//  Created by Apple on 9/07/22.
//

import Foundation
import ObjectMapper

struct Location: Mappable {
    var lat: String = ""
    var log: String = ""
    
    init(){}
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        lat <- map ["lat"]
        log <- map ["lng"]
    }
    
}
