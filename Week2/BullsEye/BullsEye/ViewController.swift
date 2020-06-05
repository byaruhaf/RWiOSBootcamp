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
    var model = BullsEyeGame()
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
        self.gameAlert(model.gamePointsCalculator()) {
            self.model.startRound()
            self.slider.value = Float(self.model.gameStartValue)
        }
    }

    @IBAction func sliderMoved(_ slider: UISlider) {
        model.playerValue = Int(slider.value.rounded())
    }

    @IBAction func startNewGame() {
        model.startGame()
    }

    fileprivate func subscribeToModel() {
        model.$score.map{$0.description}
            .assign(to: \.text, on: scoreLabel).store(in: &cancellables)
        model.$round.map{$0.description}
            .assign(to: \.text, on: roundLabel).store(in: &cancellables)
        model.$gameTargetValue.map{$0.description}
            .assign(to: \.text, on: targetLabel).store(in: &cancellables)
    }
}
