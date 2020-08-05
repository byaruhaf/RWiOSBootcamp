//
//  ViewController.swift
//  Mixer
//
//  Created by Franklin Byaruhanga on 05/08/2020.
//  Copyright © 2020 Franklin Byaruhanga. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var stageview: UIView!
    var viewAnimations:[Animator] = []

    // A yellow box
    let playBox = UIView(frame: CGRect(x: 10, y: 10, width: 40, height: 40))

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        stageview.backgroundColor = UIColor.red
        playBox.backgroundColor = UIColor.yellow
        stageview.addSubview(playBox)

    }

    func performMix() {
        playBox.performInParallel(viewAnimations)
    }

    func resetMix() {
        viewAnimations.removeAll()
        viewAnimations.append(.resize(to: CGSize(width: 40, height: 40)))
        playBox.performInParallel(viewAnimations)
    }


    @IBAction func mixAnimation(_ sender: Any) {
        performMix()
    }

    @IBAction func addAnimation1(_ sender: Any) {
        viewAnimations.append(.fadeIn())
        viewAnimations.append(.colorChange())
    }

    @IBAction func addAnimation2(_ sender: Any) {
        viewAnimations.append(.resize(to: CGSize(width: 200, height: 200)))
        viewAnimations.append(.move())
    }

    @IBAction func addAnimation3(_ sender: Any) {
        resetMix()
    }
}

