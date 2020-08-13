//
//  ViewController.swift
//  Mixer
//
//  Created by Franklin Byaruhanga on 07/08/2020.
//  Copyright © 2020 Franklin Byaruhanga. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var notificationView: UIView!
    @IBOutlet weak var playPauseBtn: UIButton!
    @IBOutlet weak var rotateBtn: UIButton!
    @IBOutlet weak var resizeBtn: UIButton!
    @IBOutlet weak var moveBtn: UIButton!
    @IBOutlet weak var rotateBtnLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var resizeBtnBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var moveBtnTrailingConstraint: NSLayoutConstraint!
    @IBOutlet weak var rotateBtnYConstraint: NSLayoutConstraint!
    @IBOutlet weak var moveBtnYConstraint: NSLayoutConstraint!
    @IBOutlet weak var notificationTopConstraint: NSLayoutConstraint!
    private var isMenueShowing = false
    private let animator = Animator()


    override func viewDidLoad() {
        super.viewDidLoad()
        showHideMenu()
        addAnimationObject()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }



    @IBAction func playPauseTapped(_ sender: Any) {
        showHideMenu()
        animator.startAnimations(in: spaceShip, when: isMenueShowing)
    }

    @IBAction func resizeTapped(_ sender: Any) {
        animator.addresizeAnimation(to: spaceShip, with: 4.0)
        notificationController()
    }
    @IBAction func moveTapped(_ sender: Any) {
        animator.addMoveAnimation(to: spaceShip)
        notificationController()
    }
    @IBAction func visualTapped(_ sender: Any) {
        animator.addRotationAnimation(to: spaceShip)
        notificationController() 
    }


    fileprivate func notificationController() {
        self.notificationTopConstraint.constant = 0
        UIView.animate(withDuration: 0.8, animations: { [view = self.view!] in
            view.layoutIfNeeded()
        }) { _ in
            self.notificationTopConstraint.constant = -70
            UIView.animate(withDuration: 0.8, delay: 0.4, options: .curveEaseOut, animations: { [view = self.view!] in
                view.layoutIfNeeded()
            })
//            UIView.animate(withDuration: 2, delay: 1) { [view = self.view!] in
//                view.layoutIfNeeded()
//            }
        }
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

    fileprivate lazy var spaceShip: UIImageView = {
        let spaceshipImage = UIImageView(frame: CGRect(x: 10, y: 10, width: 50, height: 50))
        spaceshipImage.image = UIImage(named: "spaceshipMain")
        spaceshipImage.contentMode = .scaleAspectFit
        return spaceshipImage
    }()

    fileprivate func addAnimationObject() {
        view.addSubview(spaceShip)
    }

    fileprivate func showHideMenu() {
        UIView.animate(withDuration: 0.4) {
            self.menucontroller()
            self.view.layoutIfNeeded()
        }
         isMenueShowing.toggle()
    }


}


private func delay(seconds: TimeInterval, execute: @escaping () -> Void) {
    DispatchQueue.main.asyncAfter(deadline: .now() + seconds, execute: execute)
}
