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
    var isLiked: Bool {
        let storageKey = "liked_posts"
        let storage = UserDefaults.standard
        let postIds = storage.object(forKey: storageKey) as? [Int] ?? [Int]()
        return postIds.contains(id)
    }
    var imageUser: String {
        return "user\(userID)"
    }
    
    init() {}
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        userID <- map ["userId"]
        id <- map ["id"]
        title <- map ["title"]
        body <- map ["body"]
    }
}
