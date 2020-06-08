//
//  IntExtension.swift
//  
//
//  Created by Franklin Byaruhanga on 08/06/2020.
//

import Foundation

protocol BullsEyeGameAble {
    static func random() -> Self
}

extension Int: BullsEyeGameAble  {
    static func random() -> Int {
        return Int.random(in: 0...100)
    }
}

