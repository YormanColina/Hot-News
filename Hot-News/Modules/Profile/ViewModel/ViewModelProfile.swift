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
    
    // Call the ApiService functions that call the services and obtain the observables to combine the two signals they send and transform them into a tuple signal through the zip operator
    func getProfileDetail() -> Observable<(User, [Post])> {
        let postsSignal = apiServices.makeRequestPosts()
        let userSignal = apiServices.makeRequestUser()
    
        return Observable.zip(userSignal, postsSignal)
    }
}
