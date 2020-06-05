//
//  ViewController.swift
//  BullsEye
//
//  Created by Ray Wenderlich on 6/13/18.
//  Copyright © 2018 Ray Wenderlich. All rights reserved.
//

import UIKit
import Combine

class ViewController: UIViewController {
    var gameModel = BullsEyeGame()
    var cancellables = Set<AnyCancellable>()

    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var targetLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var roundLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        startNewGame()
        subscribeToModel()
    }

    @IBAction func showAlert() {
        self.gameAlert(gameModel.gamePointsCalculator()) {
            self.gameModel.startRound()
            self.slider.value = Float(self.gameModel.gameStartValue)
        }
    }

    @IBAction func sliderMoved(_ slider: UISlider) {
        gameModel.playerValue = Int(slider.value.rounded())
    }

    @IBAction func startNewGame() {
        gameModel.startGame()
    }

    fileprivate func subscribeToModel() {
        gameModel.$score.map{$0.description}
            .assign(to: \.text, on: scoreLabel).store(in: &cancellables)
        gameModel.$round.map{$0.description}
            .assign(to: \.text, on: roundLabel).store(in: &cancellables)
        gameModel.$gameTargetValue.map{$0.description}
            .assign(to: \.text, on: targetLabel).store(in: &cancellables)
    }
}
