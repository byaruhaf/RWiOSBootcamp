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
    public var isHighScore = false
    var gameStartValue = RGB()
    var playerValue = RGB()

    init() {
    }


    /// A Function to start the game
    func start() {
        score = 0
        round = 0
        startRound()
    }


    /// A Function to start new round by generating a random TargetValue
    func startRound() {
        round += 1
        targetValue = RGB.random()
        isHighScore = false
    }


    /// A Function to calculate game point
    /// - Parameter percentageDifference:  The percentage difference  between target and player values
    /// - Returns: A tuple with total points and message to the player
    func pointsCalculator(for percentageDifference:Int) -> (points:Int,message:String) {
        // Basic Points
        var points = 100 - percentageDifference

        let message: String

        // Calulate Bonus Points
        if percentageDifference == 0 {
            message = "Perfect!"
            isHighScore = true
            points += 100
        } else if percentageDifference < 5 {
            message = "You almost had it!"
            if percentageDifference == 1 {
                isHighScore = true
                points += 50
            }
        } else if percentageDifference < 10 {
            message = "Pretty good!"
        } else {
            message = "Not even close..."
        }

        //Base points & Bonus points are added to score
        score += points

        return (points,message)
    }

}

