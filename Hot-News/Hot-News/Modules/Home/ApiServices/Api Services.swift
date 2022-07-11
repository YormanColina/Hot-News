//
//  Api Services.swift
//  Hot-News
//
//  Created by Apple on 8/07/22.
//

import Foundation
import Alamofire
import ObjectMapper
import RxSwift
import RxCocoa

protocol ApiServicesProtocol {
    func makeRequest() -> Observable<[Post]>
}

struct ApiServices: ApiServicesProtocol {
    private let postsEndpoint: URL = URL(string: "https://jsonplaceholder.typicode.com/posts")!
    
    // // Call the network service through Alamofire and transform the data into an array of publications using ObjectMapper and sending the instances through a signal using RxSwift, in case of error an error signal is sent
    func makeRequest() -> Observable<[Post]> {
        return Observable.create { observer in
            AF.request(postsEndpoint).responseJSON { response in
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
}

