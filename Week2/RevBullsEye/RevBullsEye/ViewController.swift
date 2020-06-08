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
    var guessTextLength: Int = 0
    var highScoreAnimation = HighScoreAnimation()
//    let textValueChangePublisher = NotificationCenter.Publisher.init(center: .default, name: UITextField.textDidChangeNotification , object: nil)

    

    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var targetTextField: UITextField!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var roundLabel: UILabel!
    @IBOutlet weak var warnLabel: UILabel!
    @IBOutlet weak var hitMeButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        animationSetup()
        setupTextFields()
        startNewGame()
        subscribeToModel()
//        setPublisher()
        slider.isUserInteractionEnabled = false
        hitMeButton.isEnabled = false
        targetTextField.addTarget(self, action: #selector(editingChanged), for: .editingChanged)

    }

    @IBAction func showAlert() {
        guard let text = targetTextField.text else { return }
        guard let playerValue = Int(text) else { return  }
        game.playerValue = playerValue

//        let percentageDifference = abs(game.targetValue - game.playerValue)
        let result = game.pointsCalculator(for:game.percentageDifference)
        if game.isHighScore {
            self.view.layer.addSublayer(highScoreAnimation.emitter)
        }
        self.gameAlert(result) { [weak self] in
            self?.game.startRound()
            self?.newRoundSetup()
        }
    }




    @IBAction func userGuessDidChange(_ sender: UITextField) {
        guard let text = sender.text else { return }
        guard let playerValue = Int(text) else { return  }
        game.playerValue = playerValue
        print(playerValue)
                    self.slider.minimumTrackTintColor =
                        UIColor.blue.withAlphaComponent(CGFloat(self.game.percentageDifference)/100.0)
    }

    @objc func editingChanged(_ textField: UITextField) {
        if textField.text?.count == 1 {
            if textField.text?.first == " " {
                textField.text = ""
                return
            }
        }
        guard let guess = targetTextField.text, !guess.isEmpty
            else {
                hitMeButton.isEnabled = false
                return
        }
        guard let guessNum = Int(guess), (1...100).contains(guessNum)
            else {
                hitMeButton.isEnabled = false
                return
        }
        hitMeButton.isEnabled = true
        self.slider.minimumTrackTintColor =
            UIColor.blue.withAlphaComponent(CGFloat(self.game.percentageDifference)/100.0)
    }


    @IBAction func startNewGame() {
        print("Starting")
        game.start()
        self.slider.value = Float(self.game.targetValue)
        print("\(slider.value)")
    }

    fileprivate func subscribeToModel() {
        game.$score.sink { [weak self] in self?.scoreLabel.text = $0.description }
            .store(in: &cancellables)
        game.$round.sink { [weak self] in self?.roundLabel.text = $0.description }
            .store(in: &cancellables)
    }

    fileprivate func newRoundSetup() {
        self.slider.value = Float(self.game.targetValue)
        self.targetTextField.text = ""
        self.hitMeButton.isEnabled = false
        self.highScoreAnimation.emitter.removeFromSuperlayer()
    }

    fileprivate func animationSetup() {
        highScoreAnimation.emitter.emitterPosition = CGPoint(x: self.view.frame.size.width / 2, y: -10)
        highScoreAnimation.emitter.emitterShape = CAEmitterLayerEmitterShape.line
        highScoreAnimation.emitter.emitterSize = CGSize(width: self.view.frame.size.width, height: 2.0)
        highScoreAnimation.emitter.emitterCells = highScoreAnimation.generateEmitterCells()
    }

    func setupTextFields() {
        // Dissmiss keyboard by touching anywhere on the screen
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
        // Dissmiss keyboard by taping the Done button
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

//    func setPublisher() {
//        let textFieldTextCounter = Publishers.Map(upstream: self.textValueChangePublisher) { notification -> Int in
//            let length = (notification.object as! UITextField).text?.count ?? 0
//            if length > 3 {
//                self.warnLabel.text = "Entered text length is invalid"
//            }
//            else {
//                self.warnLabel.text = ""
//            }
//            return length
//        }
//        .compactMap { $0.object as? UITextField }
//        .map { $0.text ?? "" }
//
//        let nameTextFieldSubscriber = Subscribers.Assign(object: self, keyPath: \.guessTextLength)
//
//        textFieldTextCounter.subscribe(nameTextFieldSubscriber)
//    }


}


