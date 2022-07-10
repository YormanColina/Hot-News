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
    func getProfileDetail() -> Observable<(User, [Post])>
    var posts: [Post] { get set  }
    var user: User { get set }
}

class ViewModelProfile: ViewModelProfileProtocol {
    private var apiServices: ApiServiceProfileProtocol
    var posts: [Post] = []
    var user: User
    private let disposebag = DisposeBag()
    
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
