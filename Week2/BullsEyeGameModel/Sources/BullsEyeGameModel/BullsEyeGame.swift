//
//  BullsEyeGame.swift
//  BullsEye
//
//  Created by Franklin Byaruhanga on 05/06/2020.
//  Copyright © 2020 Ray Wenderlich. All rights reserved.
//

import Foundation
import Combine

@available(iOS 13.0, *)
public class BullsEyeGame {
    @Published public var targetValue = 0
    @Published public var score = 0
    @Published public var round = 0
    public var gameStartValue = 0
    public var playerValue = 0

    public init() {
    }


    public func start() {
        score = 0
        round = 0
        startRound()
    }

    public func startRound() {
        round += 1
        targetValue = Int.random(in: 1...100)
        gameStartValue = 50
    }

    public func pointsCalculator(for difference:Int) -> (points:Int,message:String) {
        var points = 100 - difference

        score += points
        var message:String {
            if difference == 0 {
                points += 100
                return "Perfect!"
            } else if difference < 5 {
                if difference == 1 {
                    points += 50
                }
                return "You almost had it!"
            } else if difference < 10 {
                return "Pretty good!"
            } else {
                return "Not even close..."
            }
        }
        return (points,message)
    }

}

