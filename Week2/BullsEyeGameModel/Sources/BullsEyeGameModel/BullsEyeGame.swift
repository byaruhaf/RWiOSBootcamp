//
//  BullsEyeGame.swift
//  BullsEye
//
//  Created by Franklin Byaruhanga on 05/06/2020.
//  Copyright © 2020 Ray Wenderlich. All rights reserved.
//

import Foundation
import Combine

protocol BullsEyeGameAble {
    static func random() -> Self
}

@available(iOS 13.0, *)
public class BullsEyeGame {
    @Published public var targetValue = 0
    @Published public var score = 0
    @Published public var round = 0
    public var gameStartValue = 0
    public var playerValue = 0
    public var isHighScore = false
    public var percentageDifference: Int { return abs(targetValue - playerValue) }

    public init() {}


    /// A Function to start the game
    public func start() {
        score = 0
        round = 0
        startRound()
    }


    /// A Function to start new round by generating a random TargetValue
    public func startRound() {
        round += 1
        targetValue = Int.random()
        gameStartValue = 50
        isHighScore = false
    }


    /// A Function to calculate game point
    /// - Parameter percentageDifference:  The percentage difference  between target and player values
    /// - Returns: A tuple with total points and message to the player
    public func pointsCalculator(for percentageDifference:Int) -> (points:Int,message:String) {
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

