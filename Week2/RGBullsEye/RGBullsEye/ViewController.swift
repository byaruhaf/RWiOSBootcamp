/*
 * Copyright (c) 2015 Razeware LLC
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

import UIKit
import Combine

class ViewController: UIViewController {
    @IBOutlet weak var targetLabel: UILabel!
    @IBOutlet weak var targetTextLabel: UILabel!
    @IBOutlet weak var guessLabel: UILabel!
    @IBOutlet weak var redLabel: UILabel!
    @IBOutlet weak var greenLabel: UILabel!
    @IBOutlet weak var blueLabel: UILabel!
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    @IBOutlet weak var roundLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    let game = BullsEyeGame()
    var cancellables = Set<AnyCancellable>()
    var highScoreAnimation = HighScoreAnimation()

    @IBAction func aSliderMoved(sender: UISlider) {
        updatedSliderLables()
        game.playerValue = RGB(r: Int(redSlider.value), g: Int(greenSlider.value), b: Int(blueSlider.value))
        guessLabel.backgroundColor = UIColor(rgbStruct:game.playerValue)
    }


    @IBAction func showAlert(sender: AnyObject) {
        displayTargetRGB()
        let percentageDifference = Int(game.playerValue.difference(target: game.targetValue))
        let result = game.pointsCalculator(for:percentageDifference)
        if game.isHighScore {
            self.view.layer.addSublayer(highScoreAnimation.emitter)
        }
        self.gameAlert(result) { [weak self] in
            self?.game.startRound()
            self?.targetTextLabel.attributedText = NSMutableAttributedString(string:"match this color")
            self?.highScoreAnimation.emitter.removeFromSuperlayer()
        }
    }

    @IBAction func startOver(sender: AnyObject) {
        game.start()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        animationSetup()
        game.start()
        subscribeToModel()
    }

    fileprivate func updatedSliderLables(){
        self.redLabel.text = "\(Int(redSlider.value))"
        self.greenLabel.text = "\(Int(greenSlider.value))"
        self.blueLabel.text = "\(Int(blueSlider.value))"
    }

    fileprivate func subscribeToModel() {
        game.$score.sink { [weak self] in self?.scoreLabel.text = $0.description }
            .store(in: &cancellables)
        game.$round.sink { [weak self] in self?.roundLabel.text = $0.description }
            .store(in: &cancellables)
        game.$targetValue.sink { [weak self] in self?.targetLabel.backgroundColor = UIColor(rgbStruct: $0) }
            .store(in: &self.cancellables)
    }

    fileprivate func animationSetup() {
        highScoreAnimation.emitter.emitterPosition = CGPoint(x: self.view.frame.size.width / 2, y: -10)
        highScoreAnimation.emitter.emitterShape = CAEmitterLayerEmitterShape.line
        highScoreAnimation.emitter.emitterSize = CGSize(width: self.view.frame.size.width, height: 2.0)
        highScoreAnimation.emitter.emitterCells = highScoreAnimation.generateEmitterCells()
    }

    fileprivate func displayTargetRGB() {
        // Create the attributed string
        let rgbTargetString = NSMutableAttributedString(string:"")
        // Declare the colors
        let myStringColor1 = UIColor.systemRed
        let myStringColor2 = UIColor.systemGreen
        let myStringColor3 = UIColor.systemBlue
        // Create the attributes and add them to the string
        let firstAttributes = [NSAttributedString.Key.foregroundColor: myStringColor1]
        let secondAttributes = [NSAttributedString.Key.foregroundColor: myStringColor2]
        let thirdAttributes = [NSAttributedString.Key.foregroundColor: myStringColor3]
        // add them to the strings
        let firstString = NSMutableAttributedString(string: "Red: \(game.targetValue.r) ", attributes: firstAttributes)
        let secondString = NSAttributedString(string: "Green: \(game.targetValue.g) ", attributes: secondAttributes)
        let thirdString = NSAttributedString(string: "Blue: \(game.targetValue.b)", attributes: thirdAttributes)
        //join them together
        rgbTargetString.append(firstString)
        rgbTargetString.append(secondString)
        rgbTargetString.append(thirdString)
        targetTextLabel.attributedText = rgbTargetString
    }
}
