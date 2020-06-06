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
    @IBOutlet weak var targetTextField: UITextField!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var roundLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
        setupTextFields()
        slider.isUserInteractionEnabled = false
        startNewGame()
        subscribeToModel()
    }

    @IBAction func showAlert() {
        guard let text = targetTextField.text else { return }
        guard let playerValue = Int(text) else { return  }
        game.playerValue = playerValue

        let difference = abs(game.targetValue - game.playerValue)
        self.gameAlert(game.pointsCalculator(for:difference)) {
            self.game.startRound()
            self.slider.value = Float(self.game.targetValue)
            self.targetTextField.text = ""
        }
    }


    @IBAction func startNewGame() {
        print("Starting")
        game.start()
        self.slider.value = Float(self.game.targetValue)
        print("\(slider.value)")
    }

    fileprivate func subscribeToModel() {
        game.$score.map{$0.description}
            .assign(to: \.text, on: scoreLabel).store(in: &cancellables)
        game.$round.map{$0.description}
            .assign(to: \.text, on: roundLabel).store(in: &cancellables)
    }

    func setupTextFields() {
        let toolbar = UIToolbar(frame: CGRect(origin: .zero, size: CGSize(width: view.frame.size.width, height: 30)))
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        let doneBtn = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneEditing))
        toolbar.setItems([doneBtn,flexSpace], animated: false)
        toolbar.sizeToFit()

        targetTextField.inputAccessoryView = toolbar
    }

    @objc func doneEditing() {
        self.view.endEditing(true)
    }


}


