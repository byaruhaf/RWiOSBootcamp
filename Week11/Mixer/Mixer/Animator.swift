//
//  Animator.swift
//  Mixer
//
//  Created by Franklin Byaruhanga on 05/08/2020.
//  Copyright © 2020 Franklin Byaruhanga. All rights reserved.
//

import UIKit

public struct Animator {
    public let duration: TimeInterval
    public let closure: (UIView) -> Void
}

public extension Animator {
    static func fadeIn(duration: TimeInterval = 3) -> Animator {
        return Animator(duration: duration, closure: { $0.alpha = 1 })
    }

    static func resize(to size: CGSize, duration: TimeInterval = 3) -> Animator {
//        return Animator(duration: duration, closure: { $0.bounds.size = size })
        return Animator(duration: duration, closure: {   $0.transform = CGAffineTransform(scaleX: 3, y: 3) })

    }

    static func move(duration: TimeInterval = 3) -> Animator {
        return Animator(duration: duration, closure: {  $0.center = CGPoint(x: 198, y: 320) })
    }

    static func rotate(duration: TimeInterval = 3) -> Animator {
        return Animator(duration: duration, closure: {   $0.transform = CGAffineTransform(rotationAngle: .pi/4) })
    }

}


@nonobjc public extension UIView {
    func perform(_ animations: [Animator]) {
        // Exit condition: once all animations have been performed, we can return
        guard !animations.isEmpty else {
            return
        }

        // Remove the first animation from the queue
        var animations = animations
        let animation = animations.removeFirst()

        // Perform the animation by calling its closure
        UIView.animate(withDuration: animation.duration, animations: {
            animation.closure(self)
        }, completion: { _ in
            // Recursively call the method, to perform each animation in sequence
            self.perform(animations)
        })
    }
}

@nonobjc public extension UIView {
    func performInParallel(_ animations: [Animator]) {
        for animation in animations {
            UIView.animate(withDuration: animation.duration) {
                animation.closure(self)
            }
        }
    }
}
