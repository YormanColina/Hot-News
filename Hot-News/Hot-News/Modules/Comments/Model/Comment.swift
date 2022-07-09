//
//  Comment.swift
//  Hot-News
//
//  Created by Apple on 9/07/22.
//

import Foundation
import ObjectMapper

struct Comment: Mappable {
    var postId: Int = 0
    var id: Int = 0
    var name: String = ""
    var email: String = ""
    var body: String = ""
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        postId <- map ["postId"]
        id <- map ["id"]
        name <- map ["name"]
        email <- map ["email"]
        body <- map ["body"]
    }
}
