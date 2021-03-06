//
//  ViewModelComments.swift
//  Hot-News
//
//  Created by Apple on 9/07/22.
//

import Foundation
import RxCocoa
import RxSwift

protocol ViewModelCommentsProtocol {
    func getPostDetails() -> Observable<([Comment], User)>
    var comments: [Comment] { get set }
    var post: Post { get set }
    var user: User { get set }
}

class ViewModelComments: ViewModelCommentsProtocol {
    private var apiService: ApiServicesCommentsProtocol
    var comments: [Comment] = []
    var post: Post
    var user: User
    
    init(apiService: ApiServicesCommentsProtocol = ApiServicesComments(), post: Post) {
        self.apiService = apiService
        self.post = post
        self.user = User()
    }
    
    // Call the ApiService functions that call the services and obtain the observables to combine the two signals they send and transform them into a tuple signal through the zip operator
    func getPostDetails() -> Observable<([Comment], User)> {
        let commentsSignal = apiService.makeCommentsRequest(id: post.id)
        let userSignal = apiService.makeUserRequest(id: post.userID)
        
        return Observable.zip(commentsSignal, userSignal)
    }
}
