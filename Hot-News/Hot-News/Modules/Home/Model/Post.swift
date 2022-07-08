//
//  Post.swift
//  Hot-News
//
//  Created by Apple on 8/07/22.
//

import Foundation
import ObjectMapper


struct Post: Mappable {
    var userID: Int = 0
    var id: Int = 0
    var title: String = ""
    var body: String = ""
    
    init() {}
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        userID <- map ["userId"]
        id <- map ["id"]
        title <- map ["title"]
        body <- map ["body"]
    }
}
