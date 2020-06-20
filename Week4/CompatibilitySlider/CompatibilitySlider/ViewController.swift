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
    @IBOutlet weak var emo4: UIImageView!
    @IBOutlet weak var emo3: UIImageView!
    @IBOutlet weak var emo2: UIImageView!
    @IBOutlet weak var emo1: UIImageView!
    @IBOutlet weak var emo0: UIImageView!

    var compatibilityItems = ["Koala", "Dingo", "Kangaroo", "Wombat"]
    var currentItemIndex = 0

    var person1 = Person(id: 1, items: [:])
    var person2 = Person(id: 2, items: [:])
    var currentPerson: Person?
    var isperson1DonePlaying = false
    var isperson2DonePlaying = false

    override func viewDidLoad() {
        super.viewDidLoad()
        setupImageTap()
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
                    Alert.showBasic(title: "Results", message: "you two are \(calculateCompatibility()) compatible", vc: self)
                    startGame()
                default:
                    Alert.showBasic(title: "Logic Error", message: "Please contact Developer", vc: self)
            }
        }
    }
}

extension ViewController {
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        let emo = tapGestureRecognizer.view as! UIImageView

        switch emo.tag {
            case 0:
                slider.value = 5
            case 1:
                slider.value = 4
            case 2:
                slider.value = 3
            case 3:
                slider.value = 2
            case 4:
                slider.value = 1
            default:
                Alert.showBasic(title: "Logic Error", message: "Please contact Developer", vc: self)
        }
    }

    fileprivate func setupImageTap() {
        let tapGestureRecognizer4 = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        let tapGestureRecognizer3 = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        let tapGestureRecognizer2 = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        let tapGestureRecognizer1 = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        let tapGestureRecognizer0 = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        emo4.isUserInteractionEnabled = true
        emo4.addGestureRecognizer(tapGestureRecognizer4)
        emo3.isUserInteractionEnabled = true
        emo3.addGestureRecognizer(tapGestureRecognizer3)
        emo2.isUserInteractionEnabled = true
        emo2.addGestureRecognizer(tapGestureRecognizer2)
        emo1.isUserInteractionEnabled = true
        emo1.addGestureRecognizer(tapGestureRecognizer1)
        emo0.isUserInteractionEnabled = true
        emo0.addGestureRecognizer(tapGestureRecognizer0)
    }
}