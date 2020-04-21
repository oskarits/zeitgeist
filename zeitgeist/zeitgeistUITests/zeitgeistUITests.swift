//
//  zeitgeistUITests.swift
//  zeitgeistUITests
//
//  Created by Jari Pietikäinen on 19.3.2020.
//  Copyright © 2020 Z Team. All rights reserved.
//

import XCTest

class zeitgeistUITests: XCTestCase {
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testExample() {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        
        // Selects middle tabView
        let searchTab = app.tabBars.firstMatch
        searchTab.tap()

        // Open search filter tabs
        let sizeButton = app.images["sizeFilter"]
        sizeButton.tap()
        let priceButton = app.images["priceFilter"]
        priceButton.tap()

        // Close search filter tabs
        sizeButton.tap()
        priceButton.tap()

        // Toggle keyboard up
        let searchText = app.staticTexts["Cancel"]
        searchText.tap()

        // Type with keyboard
        app.keys["t"].tap()
        app.keys["e"].tap()
        app.keys["s"].tap()
        app.keys["t"].tap()
        app.keys["i"].tap()

        // Toggle keyboard down
        searchText.tap()
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testLaunchPerformance() {
        if #available(iOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }
}
