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
    var likes: Int { get set }
    func callService() -> Observable<[Post]>
}

class ViewModelHome: ViewModelHomeProtocol {
    // MARK: Properties
    private var apiServices: ApiServicesProtocol
    private var disposeBag = DisposeBag()
    var posts: [Post] = []
    var likes: Int = 0
  
    init(apiServices: ApiServicesProtocol = ApiServices()) {
        self .apiServices = apiServices
    }
    
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
}
