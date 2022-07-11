//
//  ViewModelProfile.swift
//  Hot-News
//
//  Created by Apple on 10/07/22.
//

import Foundation
import RxCocoa
import RxSwift

protocol ViewModelProfileProtocol {
    var posts: [Post] { get set  }
    var user: User { get set }
    var likes: Int { get }
    func getProfileDetail() -> Observable<(User, [Post])>
}

class ViewModelProfile: ViewModelProfileProtocol {
    private var apiServices: ApiServiceProfileProtocol
    var posts: [Post] = []
    var user: User
    var likes: Int {
        let storageKey = "liked_posts"
        let storage = UserDefaults.standard
        let postIds = storage.object(forKey: storageKey) as? [Int] ?? [Int]()
        return postIds.count
    }
   
    init(apiServices: ApiServiceProfileProtocol = ApiServiceProfile()) {
        self.apiServices = apiServices
        user = User()
    }
    
    func getProfileDetail() -> Observable<(User, [Post])> {
        let postsSignal = apiServices.makeRequestPosts()
        let userSignal = apiServices.makeRequestUser()
    
        return Observable.zip(userSignal, postsSignal)
    }
}
