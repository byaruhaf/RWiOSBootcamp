//
//  CompatibilitySlider_StartUITests.swift
//  CompatibilitySliderUITests
//
//  Created by Jay Strawn on 6/16/20.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//

import XCTest

class CompatibilitySlider_StartUITests: XCTestCase {

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

        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.

        let app = XCUIApplication()
        app.launch()
        app.images["terrible"].tap()
        app.images["bad"].tap()
        app.images["meh"].tap()
        app.images["good"].tap()

        let greatImage = app.images["great"]
        greatImage.tap()

        let nextItemStaticText = app/*@START_MENU_TOKEN@*/.staticTexts["Next Item"]/*[[".buttons[\"Next Item\"].staticTexts[\"Next Item\"]",".staticTexts[\"Next Item\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        nextItemStaticText.tap()
        greatImage.tap()
        nextItemStaticText.tap()
        greatImage.tap()
        app.buttons["Next Item"].tap()
        greatImage.tap()
        nextItemStaticText.tap()
        greatImage.tap()
        nextItemStaticText.tap()
        greatImage.tap()
        nextItemStaticText.tap()
        greatImage.tap()
        nextItemStaticText.tap()
        greatImage.tap()
        nextItemStaticText.tap()
        app.alerts["Results"].scrollViews.otherElements.buttons["OK"].tap()


    }
}
