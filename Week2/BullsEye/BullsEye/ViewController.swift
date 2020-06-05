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
    let roundedValue = slider.value.rounded()
    model.currentValue = Int(roundedValue)
    startNewGame()
  }

  @IBAction func showAlert() {
    
    let difference = abs(model.targetValue - model.currentValue)
    var points = 100 - difference
    
    model.score += points
    
    let title: String
    if difference == 0 {
      title = "Perfect!"
      points += 100
    } else if difference < 5 {
      title = "You almost had it!"
      if difference == 1 {
        points += 50
      }
    } else if difference < 10 {
      title = "Pretty good!"
    } else {
      title = "Not even close..."
    }
    
    let message = "You scored \(points) points"
    
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    
    let action = UIAlertAction(title: "OK", style: .default, handler: {
      action in
      self.startNewRound()
    })
    
    alert.addAction(action)
    
    present(alert, animated: true, completion: nil)
    
  }
  
  @IBAction func sliderMoved(_ slider: UISlider) {
    let roundedValue = slider.value.rounded()
    model.currentValue = Int(roundedValue)
  }
  
  func startNewRound() {
    model.round += 1
    model.targetValue = Int.random(in: 1...100)
    model.currentValue = 50
    slider.value = Float(model.currentValue)
    updateLabels()
  }
  
  func updateLabels() {
    targetLabel.text = String(model.targetValue)
    scoreLabel.text = String(model.score)
    roundLabel.text = String(model.round)
  }
  
  @IBAction func startNewGame() {
    model.score = 0
    model.round = 0
    startNewRound()
  }
  
}



