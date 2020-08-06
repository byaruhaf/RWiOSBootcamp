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
    @IBOutlet weak var stageview: UIView!
    @IBOutlet weak var mixerMenuContainerView: UIView!
    var viewAnimations:[Animator] = []
    @ObservedObject var mixerViewModel = MixerViewModel()


    // A yellow box
    let playBox = UIView(frame: CGRect(x: 10, y: 10, width: 40, height: 40))

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        stageview.backgroundColor = UIColor.red
        playBox.backgroundColor = UIColor.yellow
        stageview.addSubview(playBox)

        let childView = UIHostingController(rootView: MixerMenuButton(mixerViewModel: mixerViewModel))
        addChild(childView)
        childView.view.frame = mixerMenuContainerView.bounds
        mixerMenuContainerView.addSubview(childView.view)
        childView.didMove(toParent: self)

        NotificationCenter.default.addObserver(self, selector: #selector(refreshList), name:NSNotification.Name(rawValue: "refresh"), object: nil)
    }

    @objc func refreshList(notification: NSNotification){
        performMix()
    }

    func performMix() {
        playBox.performInParallel(mixerViewModel.viewAnimations)
    }

    func resetMix() {
        viewAnimations.removeAll()
        viewAnimations.append(.resize(to: CGSize(width: 40, height: 40)))
        playBox.performInParallel(viewAnimations)
    }


}

