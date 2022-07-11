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
    var posts: [Post] { get set }
    func callService() -> Observable<[Post]>
    func saveLikePost(id: Int)
}

class ViewModelHome: ViewModelHomeProtocol {
    // MARK: Properties
    private let storageKey = "liked_posts"
    private let apiServices: ApiServicesProtocol
    private let disposeBag = DisposeBag()
    private let storage = UserDefaults.standard
    var posts: [Post] = []
    
    
    init(apiServices: ApiServicesProtocol = ApiServices()) {
        self .apiServices = apiServices
    }
    
    // MARK: Methods
    func callService() -> Observable<[Post]> {
        return Observable.create { observer in
            self.apiServices.makeRequest()
                .subscribe { posts in
                    self.posts = posts
                    observer.on(.next(posts))
                } onError: { error in
                    print(error.localizedDescription)
                }.disposed(by: self.disposeBag)
            return Disposables.create()
        }
    }
    
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
