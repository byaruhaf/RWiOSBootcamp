//
//  ViewController.swift
//  Mixer
//
//  Created by Franklin Byaruhanga on 07/08/2020.
//  Copyright © 2020 Franklin Byaruhanga. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var playPauseBtn: UIButton!
    @IBOutlet weak var rotateBtn: UIButton!
    @IBOutlet weak var resizeBtn: UIButton!
    @IBOutlet weak var moveBtn: UIButton!
    @IBOutlet weak var rotateBtnLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var resizeBtnBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var moveBtnTrailingConstraint: NSLayoutConstraint!
    private var isMenueShowing = false


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        playPauseBtn.layer.masksToBounds = true
        playPauseBtn.layer.cornerRadius = playPauseBtn.frame.width/2
        rotateBtn.layer.masksToBounds = true
        rotateBtn.layer.cornerRadius = rotateBtn.frame.width/2
        resizeBtn.layer.masksToBounds = true
        resizeBtn.layer.cornerRadius = resizeBtn.frame.width/2
        moveBtn.layer.masksToBounds = true
        moveBtn.layer.cornerRadius = moveBtn.frame.width/2
        isMenueShowing = false
        menucontroller()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }

    @IBAction func playPauseTapped(_ sender: Any) {
        isMenueShowing.toggle()

        UIView.animate(withDuration: 0.5) {
            self.menucontroller()
            self.view.layoutIfNeeded()
        }
    }

    private func menucontroller() {
        self.rotateBtnLeadingConstraint.constant = self.isMenueShowing ? -50 : 50
        self.resizeBtnBottomConstraint.constant = self.isMenueShowing ? -50 : 50
        self.moveBtnTrailingConstraint.constant = self.isMenueShowing ? -50 : 50
    }


}
