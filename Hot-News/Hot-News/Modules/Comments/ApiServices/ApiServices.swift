//
//  ApiServices.swift
//  Hot-News
//
//  Created by Apple on 9/07/22.
//

import Foundation
import RxSwift
import RxCocoa
import Alamofire
import ObjectMapper

protocol ApiServicesCommentsProtocol {
    func makeCommentsRequest(id: Int) -> Observable<[Comment]>
    func makeUserRequest(id: Int) -> Observable<User>
}

class ApiServicesComments: ApiServicesCommentsProtocol {
    private var commentsEndPoint: String = "https://jsonplaceholder.typicode.com/comments?postId="
    private var userEndpoint: String = "https://jsonplaceholder.typicode.com/users/"
    
    func makeCommentsRequest(id: Int) -> Observable<[Comment]> {
        return Observable.create { observer in
            let id = String(id)
            AF.request(self.commentsEndPoint + id).responseJSON { response in
                guard let json = response.value as? [[String: Any]] else {
                    observer.on(.error(RxError.noElements))
                    return
                }
                let comments = Mapper<Comment>().mapArray(JSONArray: json)
                observer.on(.next(comments))
            }
            return Disposables.create()
        }
    }
    
    func makeUserRequest(id: Int) -> Observable<User> {
        return Observable.create { observer in
            let id = String(id)
            AF.request(self.userEndpoint + id).responseJSON { response in
                guard let json = response.value as? [String: Any], let user = Mapper<User>().map(JSON: json)  else {
                    observer.on(.error(RxError.noElements))
                    return
                }
                observer.on(.next(user))
            }
            return Disposables.create()
        }
    }
}
