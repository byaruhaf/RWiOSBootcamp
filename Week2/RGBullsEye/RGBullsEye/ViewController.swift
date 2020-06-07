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

    @IBAction func aSliderMoved(sender: UISlider) {
        updatedSliderLables()
        game.playerValue = RGB(r: Int(redSlider.value), g: Int(greenSlider.value), b: Int(blueSlider.value))
        guessLabel.backgroundColor = UIColor(rgbStruct:game.playerValue)
    }

    @IBAction func showAlert(sender: AnyObject) {
        let percentageDifference = Int(game.playerValue.difference(target: game.targetValue))
        print(percentageDifference)
        self.gameAlert(game.pointsCalculator(for:percentageDifference)) {
            self.game.startRound()
        }
    }

    @IBAction func startOver(sender: AnyObject) {
        game.start()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        game.start()
        subscribeToModel()
    }

    fileprivate func updatedSliderLables(){
        self.redLabel.text = "\(Int(redSlider.value))"
        self.greenLabel.text = "\(Int(greenSlider.value))"
        self.blueLabel.text = "\(Int(blueSlider.value))"
    }

    fileprivate func subscribeToModel() {
        game.$score.map{$0.description}
            .assign(to: \.text, on: scoreLabel).store(in: &cancellables)
        game.$round.map{$0.description}
            .assign(to: \.text, on: roundLabel).store(in: &cancellables)
        game.$targetValue.map{UIColor(rgbStruct: $0)}
            .assign(to: \.backgroundColor, on: targetLabel).store(in: &cancellables)
    }
}
