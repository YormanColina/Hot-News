//
//  ApiServicesFake.swift
//  Hot-NewsTests
//
//  Created by Apple on 11/07/22.
//

import Foundation
import ObjectMapper
import RxSwift
import RxCocoa
@testable import Hot_News

class ApiServicesFakeHome: ApiServicesProtocolHome {
    func makeRequest() -> Observable<[Post]> {
        return Observable.create { observer in
            let bundle = Bundle(for: type(of: self))
            if let path = bundle.url(forResource: "HomeMockServices", withExtension: "json") {
                do {
                    let data = try Data(contentsOf: path)
                    let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                    if let jsonResult = jsonResult as? [[String: Any]] {
                        let posts = Mapper<Post>().mapArray(JSONArray: jsonResult)
                        observer.on(.next(posts))
                    }
                } catch {
                    observer.on(.error(RxError.noElements))
                }
            }
            return Disposables.create()
        }
    }
}

