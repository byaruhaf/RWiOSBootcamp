//
//  BullsEyeGame.swift
//  BullsEye
//
//  Created by Franklin Byaruhanga on 05/06/2020.
//  Copyright © 2020 Ray Wenderlich. All rights reserved.
//

import Foundation

struct BullsEyeGame {
    var gameStartValue = 0
    var gameTargetValue = 0
    var score = 0
    var round = 0

    mutating func startGame() {
        score = 0
        round = 0
    }

    mutating func startRound() {
        round += 1
        gameTargetValue = Int.random(in: 1...100)
        gameStartValue = 50

    }

    mutating func gamePointsCalculator(_ userValue:Int) -> (points:Int,message:String) {
        let difference = abs(gameTargetValue - userValue)
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

