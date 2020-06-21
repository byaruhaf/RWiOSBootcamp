//
//  CompatibilitySlider_StartTests.swift
//  CompatibilitySliderTests
//
//  Created by Jay Strawn on 6/16/20.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//

import XCTest
@testable import CompatibilitySlider
var sut: ViewController!
var sut2: ViewController!

class CompatibilitySlider_StartTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        sut = ViewController()
        sut.person1 = Person(id: 1, items: [:])
        sut.person2 = Person(id: 2, items: [:])
        sut.compatibilityItems = ["Cats", "Dogs", "Chamois"]
        sut.currentPerson =  sut.person1
        sut.currentPerson?.items.updateValue(1, forKey: "Cats")
        sut.currentPerson?.items.updateValue(1, forKey: "Dogs")
        sut.currentPerson?.items.updateValue(1, forKey: "Chamois")
        sut.currentPerson =  sut.person2
        sut.currentPerson?.items.updateValue(1, forKey: "Cats")
        sut.currentPerson?.items.updateValue(1, forKey: "Dogs")
        sut.currentPerson?.items.updateValue(1, forKey: "Chamois")

        sut2 = ViewController()
        sut2.person1 = Person(id: 1, items: [:])
        sut2.person2 = Person(id: 2, items: [:])
        sut2.compatibilityItems = ["Cats", "Dogs", "Chamois"]
        sut2.currentPerson =  sut2.person1
        sut2.currentPerson?.items.updateValue(0, forKey: "Cats")
        sut2.currentPerson?.items.updateValue(0, forKey: "Dogs")
        sut2.currentPerson?.items.updateValue(0, forKey: "Chamois")

        sut2.currentPerson =  sut2.person2
        sut2.currentPerson?.items.updateValue(5, forKey: "Cats")
        sut2.currentPerson?.items.updateValue(5, forKey: "Dogs")
        sut2.currentPerson?.items.updateValue(5, forKey: "Chamois")

 }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCompatibilityCalculation() throws {
        let result1 = sut.calculateCompatibility()
        let result2 = sut2.calculateCompatibility()
        XCTAssertEqual( "100.0%", result1)
        XCTAssertEqual( "0.0%", result2)
    }

}
