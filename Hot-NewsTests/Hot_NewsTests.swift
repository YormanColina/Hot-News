//
//  Hot_NewsTests.swift
//  Hot-NewsTests
//
//  Created by Apple on 8/07/22.
//

import XCTest
import RxSwift
import RxCocoa
@testable import Hot_News

class Hot_NewsTests: XCTestCase {
    
    private var homeViewModel: ViewModelHome!
    private let disposeBag = DisposeBag()
    

    override func setUpWithError() throws {
        homeViewModel = ViewModelHome(apiServices: ApiServicesFakeHome())
    }
    
    func testsModel() {
        let apiService = ApiServicesFakeHome()
        
        apiService.makeRequest()
            .subscribe { posts in
                if let posts = posts.element {
                    XCTAssertGreaterThan(posts.count, 0)
                    XCTAssertLessThan(posts.count, 14)
                    XCTAssertNotEqual(posts[3].id, 0)
                    XCTAssertNotEqual(posts[3].title, "")
                    XCTAssertNotEqual(posts[3].body, "")
                    XCTAssertGreaterThan(posts[3].userID, 0)
                    XCTAssertEqual(posts[3].imageUser, "user1")
                    XCTAssertEqual(posts[11].imageUser, "user2")
                }
            }.disposed(by: disposeBag)
    }
    
    func testHomeViewModel() {
        let expectation = XCTestExpectation(description: "Waiting fot viewModel signal")
        
        homeViewModel.callService()
            .subscribe { posts in
                XCTAssertFalse(self.homeViewModel.posts.isEmpty)
                expectation.fulfill()
            }.disposed(by: disposeBag)
        wait(for: [expectation], timeout: 10.0)
    }
}
