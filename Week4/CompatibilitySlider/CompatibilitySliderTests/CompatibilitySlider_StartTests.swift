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
 }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCompatibilityCalculation() throws {
        let result = sut.calculateCompatibility()
        XCTAssertEqual( "100.0%", result)   

    }

}
