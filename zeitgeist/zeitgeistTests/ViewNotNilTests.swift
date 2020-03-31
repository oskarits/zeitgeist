//
//  ViewNotNilTests.swift
//  zeitgeistTests
//
//  Created by Jari Pietikäinen on 31.3.2020.
//  Copyright © 2020 Z Team. All rights reserved.
//

import XCTest

class ViewNotNilTests: XCTestCase {
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testContentView() {
        let testableView = ContentView()
        let body = testableView.body
        XCTAssertNotNil(body)
    }
    
    func testNavigationBarView() {
        let testableView = NavigationBarView()
        let body = testableView.body
        XCTAssertNotNil(body)
    }
    
    func testProfileView() {
        let testableView = ProfileView()
        let body = testableView.body
        XCTAssertNotNil(body)
    }
    
    func testSearchView() {
        let testableView = SearchView()
        let body = testableView.body
        XCTAssertNotNil(body)
    }
    
    func testHomeView() {
        let testableView = HomeView()
        let body = testableView.body
        XCTAssertNotNil(body)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
        }
    }
    
    
}
