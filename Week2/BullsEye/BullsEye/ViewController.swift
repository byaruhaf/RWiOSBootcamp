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
    var userValue:Int = 0

  @IBOutlet weak var slider: UISlider!
  @IBOutlet weak var targetLabel: UILabel!
  @IBOutlet weak var scoreLabel: UILabel!
  @IBOutlet weak var roundLabel: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    let roundedValue = slider.value.rounded()
    model.gameStartValue = Int(roundedValue)
    startNewGame()
  }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateLabels()
    }


    @IBAction func showAlert() {
    let result = model.gamePointsCalculator(userValue)
        alert(result)
  }
  
  @IBAction func sliderMoved(_ slider: UISlider) {
    let roundedValue = slider.value.rounded()
    userValue = Int(roundedValue)
  }
  
  func startNewRound() {
    model.startRound()
    slider.value = Float(model.gameStartValue)
    updateLabels()
  }
  
  func updateLabels() {
    targetLabel.text = String(model.gameTargetValue)
    scoreLabel.text = String(model.score)
    roundLabel.text = String(model.round)
  }
  
  @IBAction func startNewGame() {
    model.startGame()
    startNewRound()
  }
  
}

extension ViewController {
    fileprivate func alert(_ result: (points: Int, message: String)) {
        let message = "You scored \(result.points) points"
        let alert = UIAlertController(title: result.message, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: {
            action in
            self.startNewRound()
        })
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}

