//
//  Birdie_FinalUITests.swift
//  BirdieUITests
//
//  Created by Jay Strawn on 6/18/20.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//

import XCTest

class Birdie_UITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // UI tests must launch the application that they test.
//        let app = XCUIApplication()
//        app.launch()


        let app = XCUIApplication()
        app/*@START_MENU_TOKEN@*/.staticTexts["Create Text Post"]/*[[".buttons[\"Create Text Post\"].staticTexts[\"Create Text Post\"]",".staticTexts[\"Create Text Post\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()

        let fKey = app/*@START_MENU_TOKEN@*/.keys["f"]/*[[".keyboards.keys[\"f\"]",".keys[\"f\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        fKey.tap()
        fKey.tap()

        let rKey = app/*@START_MENU_TOKEN@*/.keys["r"]/*[[".keyboards.keys[\"r\"]",".keys[\"r\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        rKey.tap()
        rKey.tap()

        let aKey = app/*@START_MENU_TOKEN@*/.keys["a"]/*[[".keyboards.keys[\"a\"]",".keys[\"a\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        aKey.tap()
        aKey.tap()

        let nKey = app/*@START_MENU_TOKEN@*/.keys["n"]/*[[".keyboards.keys[\"n\"]",".keys[\"n\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        nKey.tap()
        nKey.tap()
        
        let kKey = app/*@START_MENU_TOKEN@*/.keys["k"]/*[[".keyboards.keys[\"k\"]",".keys[\"k\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        kKey.tap()
        kKey.tap()
        kKey.tap()
        kKey.tap()

        let iKey = app/*@START_MENU_TOKEN@*/.keys["i"]/*[[".keyboards.keys[\"i\"]",".keys[\"i\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        iKey.tap()
        iKey.tap()
        nKey.tap()
        nKey.tap()
        app.alerts["Create Post"].scrollViews.otherElements.collectionViews/*@START_MENU_TOKEN@*/.textFields["post"]/*[[".cells.textFields[\"post\"]",".textFields[\"post\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.keys["T"]/*[[".keyboards.keys[\"T\"]",".keys[\"T\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
       

        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }
}
