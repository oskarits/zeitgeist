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
    
    func testSearch() {
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
        
        // Close price filter
        priceButton.tap()
        
        // Size options
        let sizeYourSize = app.buttons["Your size"]
        let sizeOneSize = app.buttons["One Size"]
        let size32 = app.buttons["32"]
        let size34 = app.buttons["34"]
        let size36 = app.buttons["36"]
        let size38 = app.buttons["38"]
        let size40 = app.buttons["40"]
        let size42 = app.buttons["42"]
        let size44 = app.buttons["44"]
        
        // Select all sizes
        sizeYourSize.tap()
        sizeButton.tap()
        sizeOneSize.tap()
        sizeButton.tap()
        size32.tap()
        sizeButton.tap()
        size34.tap()
        sizeButton.tap()
        size36.tap()
        sizeButton.tap()
        size38.tap()
        sizeButton.tap()
        size40.tap()
        sizeButton.tap()
        size42.tap()
        sizeButton.tap()
        size44.tap()

        // Clear size filter
        let removeSizeFilter = app.images["removeSizeFilter"]
        removeSizeFilter.tap()
        
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
