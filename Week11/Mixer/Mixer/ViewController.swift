//
//  ViewController.swift
//  Mixer
//
//  Created by Franklin Byaruhanga on 05/08/2020.
//  Copyright © 2020 Franklin Byaruhanga. All rights reserved.
//

import UIKit
import SwiftUI

class ViewController: UIViewController {
    @IBOutlet weak var spaceShip: UIImageView!
    @IBOutlet weak var mixerMenuContainerView: UIView!
    var viewAnimations:[Animator] = []
    @ObservedObject var mixerViewModel = MixerViewModel()



    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let childView = UIHostingController(rootView: MixerMenuButton(mixerViewModel: mixerViewModel))
        addChild(childView)
        let frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: mixerMenuContainerView.bounds.height)
        childView.view.frame = frame
        childView.view.backgroundColor = .clear
        mixerMenuContainerView.addSubview(childView.view)
        childView.didMove(toParent: self)

        NotificationCenter.default.addObserver(self, selector: #selector(performMixAnimations), name:NSNotification.Name(rawValue: "perform"), object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(resetMixAnimations), name:NSNotification.Name(rawValue: "reset"), object: nil)

        configureInitialSetup()
    }

    func configureInitialSetup() {
        spaceShip.alpha = 0.0
        spaceShip.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
    }

    @objc func performMixAnimations(notification: NSNotification){
        performMix()
    }

    @objc func resetMixAnimations(notification: NSNotification){
//        resetMix()
    }
    func performMix() {
        spaceShip.performInParallel(mixerViewModel.viewAnimations)


    }

    func resetMix() {
        configureInitialSetup()
        viewAnimations.removeAll()
    }


}

