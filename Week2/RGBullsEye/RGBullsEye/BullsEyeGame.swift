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

    @Published var targetValue = RGB()
    @Published var score = 0
    @Published var round = 0
     var gameStartValue = RGB()
     var playerValue = RGB()

     init() {
    }


    /// Description
     func start() {
        score = 0
        round = 0
        startRound()
    }


    /// Description
     func startRound() {
        round += 1
    targetValue = RGB(r: Int.random(in: 0...255),
                      g: Int.random(in: 0...255),
                      b: Int.random(in: 0...255))
        print(targetValue)
    }


    /// Description
    /// - Parameter percentageDifference: difference description
    /// - Returns: description
    func pointsCalculator(for percentageDifference:Int) -> (points:Int,message:String) {
        var points = 100 - percentageDifference
        score += points
        var message:String {
            if percentageDifference == 0 {
                points += 100
                return "Perfect!"
            } else if percentageDifference < 5 {
                if percentageDifference == 1 {
                    points += 50
                }
                return "You almost had it!"
            } else if percentageDifference < 10 {
                return "Pretty good!"
            } else {
                return "Not even close..."
            }
        }
        score += points
        return (points,message)
    }

}

