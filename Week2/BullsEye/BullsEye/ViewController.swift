//
//  ViewController.swift
//  BullsEye
//
//  Created by Ray Wenderlich on 6/13/18.
//  Copyright © 2018 Ray Wenderlich. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var model = BullsEyeGame()

    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var targetLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var roundLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        startNewGame()
        updateLabels()
    }

    @IBAction func showAlert() {
        let result = model.gamePointsCalculator()
        self.gameAlert(result) { self.startNewRound() }
    }

    @IBAction func sliderMoved(_ slider: UISlider) {
        let roundedValue = slider.value.rounded()
        model.playerValue = Int(roundedValue)
    }

    @IBAction func startNewGame() {
        model.startGame()
    }
    func startNewRound() {
        model.startRound()
        updateLabels()
    }

    func updateLabels() {
        slider.value = Float(model.gameStartValue)
        targetLabel.text = String(model.gameTargetValue)
        scoreLabel.text = String(model.score)
        roundLabel.text = String(model.round)
    }
}


