//
//  Animator.swift
//  Mixer
//
//  Created by Franklin Byaruhanga on 12/08/2020.
//  Copyright © 2020 Franklin Byaruhanga. All rights reserved.
//

import UIKit


public struct Animator {
    let viewAnimator = UIViewPropertyAnimator(duration: 2, curve: .linear)
}

// MARK: - Animations for Animator
public extension Animator {
    func addRotationAnimation(to view: UIView, with angleSize:CGFloat = CGFloat.pi) {
        viewAnimator.addAnimations {
            view.center = CGPoint(x: 40, y: 40)
            view.transform = .init(rotationAngle: angleSize)
        }
    }


    func addresizeAnimation(to view: UIView,with scaleSize: CGFloat = 6) {
        viewAnimator.addAnimations {
            view.center = CGPoint(x: 40, y: 40)
            view.transform = .init(scaleX: scaleSize, y: scaleSize)
        }
    }


    func addMoveAnimation(to view: UIView) {
        viewAnimator.addAnimations {
            view.transform = .init(translationX: 256, y: 256)
            view.center = CGPoint(x: 250, y: 250)
        }
    }

    func addResetAnimation(to view: UIView) {
        view.transform = .identity
    }
}

// MARK: - Animator Starter
public extension Animator {
    func startAnimations(for view: UIView, when isMenuOpen: Bool) {
        if !isMenuOpen {
            viewAnimator.startAnimation()

            viewAnimator.addCompletion { _ in
                let reversePropertyAnimator = UIViewPropertyAnimator(duration: 2, curve: .linear)
                reversePropertyAnimator.addAnimations {
                    self.addResetAnimation(to: view)
                }
                reversePropertyAnimator.startAnimation()
            }
        }
    }
}



