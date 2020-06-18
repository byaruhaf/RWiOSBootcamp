//
//  Person.swift
//  CompatibilitySlider
//
//  Created by Jay Strawn on 6/16/20.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//

import Foundation


// When you copy a struct (like set it as `currentPerson`), you end up with two unique copies of the data.
// But When you copy a class, you end up with two references to one instance of the data.
// Person is a class instead of a struct
// Because if we reference `currentPerson` in ViewController
// If we change "items" in `currentPerson` it won't change `person1`
class Person {
    var id: Int
    var items: [String: Float]

    init(id: Int, items: [String: Float]) {
        self.id = id
        self.items = items
    }
}

// Comforming to equatable means that if you want to do:
// `if user1 == user2` you can check if they're equal by looking at their `id`
// This is useful for comparing custom classes
extension Person: Equatable {
    static func == (lhs: Person, rhs: Person) -> Bool {
        // The comparision is left hand side to right hand side
        // If id is equal, treat them as the same object
        return lhs.id == rhs.id
    }
}
