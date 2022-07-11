//
//  ApiServiceProfile.swift
//  Hot-News
//
//  Created by Apple on 10/07/22.
//

import Foundation
import RxCocoa
import RxSwift
import Alamofire
import ObjectMapper

protocol ApiServiceProfileProtocol {
    func makeRequestUser() -> Observable<User>
    func makeRequestPosts() -> Observable<[Post]>
}

class ApiServiceProfile: ApiServiceProfileProtocol {
    private var endPointPosts: String = "https://jsonplaceholder.typicode.com/users/1/posts"
    private var endPointUser: String = "https://jsonplaceholder.typicode.com/users/1"
 
    init() {}

    func makeRequestPosts() -> Observable<[Post]> {
        return Observable.create { observer in
            AF.request(self.endPointPosts).responseJSON { response in
                guard let json = response.value as? [[String: Any]] else {
                    observer.on(.error(RxError.noElements))
                    return
                }
                let posts = Mapper<Post>().mapArray(JSONArray: json)
                observer.on(.next(posts))
            }
            return Disposables.create()
        }
    }
    
    
    func makeRequestUser() -> Observable<User> {
        return Observable.create { observer in
            AF.request(self.endPointUser).responseJSON { response in
                guard let json = response.value as? [String: Any], let user = Mapper<User>().map(JSON: json) else {
                    observer.on(.error(RxError.noElements))
                    return
                }
                observer.on(.next(user))
            }
            return Disposables.create()
        }
    }

}
