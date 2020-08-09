//
//  ViewController.swift
//  Mixer
//
//  Created by Franklin Byaruhanga on 07/08/2020.
//  Copyright © 2020 Franklin Byaruhanga. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //animation object instantiated
    var highScoreAnimation = HighScoreAnimation()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        animationSetup()
         self.view.layer.addSublayer(highScoreAnimation.emitter)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.highScoreAnimation.emitter.removeFromSuperlayer()
    }

    // Animaition setup for Highscore's
    fileprivate func animationSetup() {
        highScoreAnimation.emitter.emitterPosition = CGPoint(x: self.view.frame.size.width / 2, y: -10)
        highScoreAnimation.emitter.emitterShape = CAEmitterLayerEmitterShape.line
        highScoreAnimation.emitter.emitterSize = CGSize(width: self.view.frame.size.width, height: 2.0)
        highScoreAnimation.emitter.emitterCells = highScoreAnimation.generateEmitterCells()
    }

}
