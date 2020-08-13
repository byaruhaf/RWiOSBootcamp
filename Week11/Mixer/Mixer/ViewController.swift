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
    @IBOutlet weak var marsImageView: UIImageView!
    @IBOutlet weak var rotateBtnLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var resizeBtnBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var moveBtnTrailingConstraint: NSLayoutConstraint!
    @IBOutlet weak var rotateBtnYConstraint: NSLayoutConstraint!
    @IBOutlet weak var moveBtnYConstraint: NSLayoutConstraint!
    @IBOutlet weak var notificationTopConstraint: NSLayoutConstraint!
    private var isMenueOpen = false
    private let animator = Animator(finalAnimationPoint: CGPoint(x: 250, y: 250))

    fileprivate lazy var spaceShip: UIImageView = {
        let spaceshipImage = UIImageView(frame: CGRect(x: 10, y: 10, width: 100, height: 100))
        spaceshipImage.image = UIImage(named: "spaceshipMain")
        spaceshipImage.contentMode = .scaleAspectFit
        return spaceshipImage
    }()


    override func viewDidLoad() {
        super.viewDidLoad()
        showHideMenu()
        addSpaceShipObject()
        notificationTopConstraint.constant = -200
    }


// MARK: - Button Actions
    @IBAction func playPauseTapped(_ sender: Any) {
        showHideMenu()
        animator.startAnimations(for: spaceShip, when: !isMenueOpen)
    }

    @IBAction func resizeTapped(_ sender: Any) {
        animator.addresizeAnimation(to: spaceShip, with: 4.0)
        ShowNotification()
    }
    @IBAction func moveTapped(_ sender: Any) {
        animator.addMoveAnimation(to: spaceShip)
        ShowNotification()
    }
    @IBAction func visualTapped(_ sender: Any) {
        animator.addRotationAnimation(to: spaceShip)
        ShowNotification() 
    }

    fileprivate func addSpaceShipObject() {
        view.addSubview(spaceShip)
    }

    fileprivate func showHideMenu() {
        UIView.animate(withDuration: 0.4) {
            self.menuController()
            self.isMenueOpen.toggle()
            self.view.layoutIfNeeded()
        }
    }

    fileprivate func menuController() {
        self.rotateBtnLeadingConstraint.constant = self.isMenueOpen ? 50 : -50
        self.resizeBtnBottomConstraint.constant = self.isMenueOpen ? 50 : -50
        self.moveBtnTrailingConstraint.constant = self.isMenueOpen ? 50 : -50
         self.rotateBtnYConstraint.constant = self.isMenueOpen ? -45 : 0
         self.moveBtnYConstraint.constant = self.isMenueOpen ? -45 : 0
        let playImage = UIImage(systemName: "play.fill")!
        let pauseImage =  UIImage(systemName: "playpause.fill")!
        let playPauseBtnimage = self.isMenueOpen ? pauseImage : playImage
        playPauseBtn.setImage(playPauseBtnimage , for: .normal)
    }

    fileprivate func ShowNotification() {
        self.notificationTopConstraint.constant = 0
        UIView.animate(withDuration: 0.8, animations: { [view = self.view!] in
            view.layoutIfNeeded()
        }) { _ in
            self.notificationTopConstraint.constant = -200
            UIView.animate(withDuration: 0.8, delay: 0.4, options: .curveEaseOut, animations: { [view = self.view!] in
                view.layoutIfNeeded()
            })
        }
    }

}
