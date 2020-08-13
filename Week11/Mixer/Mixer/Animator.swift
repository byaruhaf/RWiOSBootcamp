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
    var finalAnimationPoint:CGPoint
}

// MARK: - Animations for Animator
public extension Animator {
    func addRotationAnimation(to view: UIView, with angleSize:CGFloat = CGFloat.pi) {
        viewAnimator.addAnimations {
            view.transform = .init(rotationAngle: angleSize)
            view.center = self.finalAnimationPoint
        }
    }


    func addresizeAnimation(to view: UIView,with scaleSize: CGFloat = 6) {
        viewAnimator.addAnimations {
            view.transform = .init(scaleX: scaleSize, y: scaleSize)
            view.center = self.finalAnimationPoint
        }
    }


    func addMoveAnimation(to view: UIView) {
        viewAnimator.addAnimations {
            view.transform = CGAffineTransform.identity.translatedBy(x: 0.0, y: 256.0)
            view.center = self.finalAnimationPoint
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



