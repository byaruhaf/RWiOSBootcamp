//
//  ViewController.swift
//  BullsEye
//
//  Created by Ray Wenderlich on 6/13/18.
//  Copyright © 2018 Ray Wenderlich. All rights reserved.
//

import UIKit
import Combine
import BullsEyeGame

class ViewController: UIViewController {
    var game = BullsEyeGame()
    var cancellables = Set<AnyCancellable>()

    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var targetLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var roundLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
//        startNewGame()
        game.start()
        subscribeToModel()
    }

    @IBAction func showAlert() {
        let difference = abs(game.targetValue - game.playerValue)
        self.gameAlert(game.pointsCalculator(for:difference)) {
            self.game.startRound()
            self.slider.value = Float(self.game.gameStartValue)
        }
    }

    @IBAction func sliderMoved(_ slider: UISlider) {
        game.playerValue = Int(slider.value.rounded())
    }

    @IBAction func startNewGame() {
        game.start()
    }

    fileprivate func subscribeToModel() {
        game.$score.map{$0.description}
            .assign(to: \.text, on: scoreLabel).store(in: &cancellables)
        game.$round.map{$0.description}
            .assign(to: \.text, on: roundLabel).store(in: &cancellables)
        game.$targetValue.map{$0.description}
            .assign(to: \.text, on: targetLabel).store(in: &cancellables)
    }
}
