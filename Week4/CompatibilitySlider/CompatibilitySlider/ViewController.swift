//
//  ViewController.swift
//  CompatibilitySlider
//
//  Created by Jay Strawn on 6/16/20.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  @IBOutlet weak var compatibilityItemLabel: UILabel!
  @IBOutlet weak var slider: UISlider!
  @IBOutlet weak var questionLabel: UILabel!

  var compatibilityItems = ["Chinchilla", "Crocodile", "Cheetah"]

  var currentItemIndex = 0

  var person1 = Person(id: 1, items: [:])
  var person2 = Person(id: 2, items: [:])
  var currentPerson: Person?
  var isperson1DonePlaying = false
  var isperson2DonePlaying = false

  override func viewDidLoad() {
    super.viewDidLoad()
    startGame()
  }

  @IBAction func sliderValueChanged(_ sender: UISlider) {
    //        print(sender.value)
  }

  @IBAction func didPressNextItemButton(_ sender: Any) {
    saveScore()
  }

  func calculateCompatibility() -> String {
    // If diff 0.0 is 100% and 5.0 is 0%, calculate match percentage
    var percentagesForAllItems: [Double] = []

    for (key, person1Rating) in person1.items {
      let person2Rating = person2.items[key] ?? 0
      let difference = abs(person1Rating - person2Rating) / 5.0
      percentagesForAllItems.append(Double(difference))
    }

    let sumOfAllPercentages = percentagesForAllItems.reduce(0, +)
    let matchPercentage = sumOfAllPercentages / Double(compatibilityItems.count)
    print(matchPercentage, "%")
    let matchString = 100 - (matchPercentage * 100).rounded()
    return "\(matchString)%"
  }

  func startGame() {
    self.currentItemIndex = 0
    isperson1DonePlaying = false
    isperson2DonePlaying = false

    startRound()
  }

  func startRound() {
    if !isperson1DonePlaying {
      currentPerson = person1

    } else {
      currentPerson = person2
    }
    if currentItemIndex < compatibilityItems.count {
      updateView(currentItemIndex)
    } else {
      saveScore()
    }
  }

  func updateView(_ currentItemIndex: Int) {

    slider.value = 3

    UIView.transition(
      with: compatibilityItemLabel,
      duration: 1,
      options: .transitionFlipFromBottom,
      animations: { [weak self] in
        self?.compatibilityItemLabel.text = self?.compatibilityItems[currentItemIndex]
      }, completion: nil)

    if !isperson1DonePlaying {
      questionLabel.text = "Player 1, what do you think about.."
    } else {
      questionLabel.text = "Player 2, what do you think about.."
    }
  }

  func saveScore() {
    if currentItemIndex < compatibilityItems.count {
      let currentItem = compatibilityItems[currentItemIndex]
      currentPerson?.items.updateValue(slider.value, forKey: currentItem)
      currentItemIndex += 1
      startRound()
    } else {
      switch (isperson1DonePlaying, isperson2DonePlaying) {
      case (false, false):
        isperson1DonePlaying = true
        currentItemIndex = 0
        startRound()
      case (true, false):
        isperson2DonePlaying = true
        currentItemIndex = 0
        Alert.showBasic(
          title: "Results", message: "you two are \(calculateCompatibility()) compatible", vc: self)
        startGame()
      default:
        print("imposible STate")
      }
    }
  }
}
