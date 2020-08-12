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
    @IBOutlet weak var rotateBtnYConstraint: NSLayoutConstraint!
    @IBOutlet weak var moveBtnYConstraint: NSLayoutConstraint!
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
        showHideMenu()
    }

    @IBAction func resizeTapped(_ sender: Any) {
    }
    @IBAction func moveTapped(_ sender: Any) {
    }
    @IBAction func visualTapped(_ sender: Any) {
    }


    fileprivate func menucontroller() {
        self.rotateBtnLeadingConstraint.constant = self.isMenueShowing ? -50 : 50
        self.resizeBtnBottomConstraint.constant = self.isMenueShowing ? -50 : 50
        self.moveBtnTrailingConstraint.constant = self.isMenueShowing ? -50 : 50
         self.rotateBtnYConstraint.constant = self.isMenueShowing ? 0 : -45
         self.moveBtnYConstraint.constant = self.isMenueShowing ? 0 : -45
        let playImage = UIImage(systemName: "play.fill")!
        let pauseImage =  UIImage(systemName: "playpause.fill")!
        let playPauseBtnimage = self.isMenueShowing ? pauseImage : playImage
        playPauseBtn.setImage(playPauseBtnimage , for: .normal)
    }

    fileprivate func showHideMenu() {
        isMenueShowing.toggle()
        UIView.animate(withDuration: 0.5) {
            self.menucontroller()
            self.view.layoutIfNeeded()
        }
    }


}
