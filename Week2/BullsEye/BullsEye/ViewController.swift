//
//  ViewController.swift
//  BullsEye
//
//  Created by Ray Wenderlich on 6/13/18.
//  Copyright © 2018 Ray Wenderlich. All rights reserved.
//

import UIKit
import Combine
import BullsEyeGameModel

class ViewController: UIViewController {
    var game = BullsEyeGame()
    var cancellables = Set<AnyCancellable>()

    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var targetLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var roundLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        game.start()
        subscribeToModel()
    }

    @IBAction func showAlert() {
        self.gameAlert(game.pointsCalculator(for:game.percentageDifference)) {
            self.game.startRound()
            self.slider.value = Float(self.game.gameStartValue)
        }
    }

    @IBAction func sliderMoved(_ slider: UISlider) {
        game.playerValue = Int(slider.value.rounded())
        setupSliderHint()
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

    fileprivate func setupSliderHint() {
        slider.minimumTrackTintColor =
            UIColor.blue.withAlphaComponent(CGFloat(game.percentageDifference)/100.0)
    }

}
