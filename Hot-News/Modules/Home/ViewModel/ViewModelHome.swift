//
//  ViewModelHome.swift
//  Hot-News
//
//  Created by Apple on 8/07/22.
//

import Foundation
import RxSwift
import RxCocoa

protocol ViewModelHomeProtocol {
    var posts: [Post] { get }
    func callService() -> Observable<[Post]>
    func saveLikePost(id: Int)
}

class ViewModelHome: ViewModelHomeProtocol {
    // MARK: Properties
    private let storageKey = "liked_posts"
    private let apiServices: ApiServicesProtocolHome
    private let disposeBag = DisposeBag()
    private let storage = UserDefaults.standard
    var posts: [Post] = []
    
    init(apiServices: ApiServicesProtocolHome = ApiServicesHome()) {
        self .apiServices = apiServices
    }
    
    // MARK: Methods
    
    // Call the ApiService so that it makes the call to the network and receive the post array through a subscription to the signal that it sends and create an observable in which the list of received messages is sent
    func callService() -> Observable<[Post]> {
        return apiServices.makeRequest().do { posts in
            self.posts = posts
        }
    }
    
    // Save the id of the post that was liked in UserDefaults or delete it if I remove the like from any publication
    func saveLikePost(id: Int) {
        var postIds = storage.object(forKey: storageKey) as? [Int] ?? [Int]()
        
        if postIds.contains(id) {
            postIds.removeAll { $0 == id }
        } else {
            postIds.append(id)
        }
        
        storage.set(postIds, forKey: storageKey)
    }
    
}
