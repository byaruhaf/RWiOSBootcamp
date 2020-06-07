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

    // Treat: Hint
    public var percentageDifference: Int { return abs(targetValue - playerValue) }

    public init() {
    }


    /// Description
    public func start() {
        score = 0
        round = 0
        startRound()
    }


    /// Description
    public func startRound() {
        round += 1
        targetValue = Int.random(in: 1...100)
        gameStartValue = 50
    }


    /// Description
    /// - Parameter percentageDifference: difference description
    /// - Returns: description
    public func pointsCalculator(for percentageDifference:Int) -> (points:Int,message:String) {
        var points = 100 - percentageDifference
        score += points
        // calculate bonus moings and determine message to user. 
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

