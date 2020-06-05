//
//  BullsEyeGame.swift
//  BullsEye
//
//  Created by Franklin Byaruhanga on 05/06/2020.
//  Copyright © 2020 Ray Wenderlich. All rights reserved.
//

import Foundation
import Combine

class BullsEyeGame {
    var gameStartValue = 0
    var playerValue = 0
    @Published var gameTargetValue = 0
    @Published var score = 0
    @Published var round = 0

    func startGame() {
        score = 0
        round = 0
        startRound()
    }

    func startRound() {
        round += 1
        gameTargetValue = Int.random(in: 1...100)
        gameStartValue = 50
    }

    func gamePointsCalculator() -> (points:Int,message:String) {
        let difference = abs(gameTargetValue - playerValue)
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
