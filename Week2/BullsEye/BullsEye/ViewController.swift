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
    var highScoreAnimation = HighScoreAnimation()

    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var targetLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var roundLabel: UILabel!
    let bluetrackImage = UIImage(named: "BlueSliderTrackLeft")


    override func viewDidLoad() {
        super.viewDidLoad()
//        sliderSetUp()
        game.start()
        subscribeToModel()
        animationSetup()
    }

    @IBAction func showAlert() {
        let result = game.pointsCalculator(for:game.percentageDifference)
        if game.isHighScore {
            self.view.layer.addSublayer(highScoreAnimation.emitter)
        }
        self.gameAlert(result) {
            self.game.startRound()
            self.slider.value = Float(self.game.gameStartValue)
            self.highScoreAnimation.emitter.removeFromSuperlayer()
            self.slider.minimumTrackTintColor = UIColor.blue
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
        game.$score.sink { [weak self] in self?.scoreLabel.text = $0.description }
            .store(in: &cancellables)
        game.$round.sink { [weak self] in self?.roundLabel.text = $0.description }
            .store(in: &cancellables)
        game.$targetValue.sink { [weak self] in self?.targetLabel.text = $0.description }
            .store(in: &cancellables)
    }

    fileprivate func setupSliderHint() {
        slider.minimumTrackTintColor =
            UIColor.blue.withAlphaComponent(CGFloat(game.percentageDifference)/100.0)
    }
    fileprivate func animationSetup() {
        highScoreAnimation.emitter.emitterPosition = CGPoint(x: self.view.frame.size.width / 2, y: -10)
        highScoreAnimation.emitter.emitterShape = CAEmitterLayerEmitterShape.line
        highScoreAnimation.emitter.emitterSize = CGSize(width: self.view.frame.size.width, height: 2.0)
        highScoreAnimation.emitter.emitterCells = highScoreAnimation.generateEmitterCells()
    }
}
