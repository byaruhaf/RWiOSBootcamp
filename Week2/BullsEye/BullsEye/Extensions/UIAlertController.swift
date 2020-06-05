//
//  UIAlertController.swift
//  BullsEye
//
//  Created by Franklin Byaruhanga on 05/06/2020.
//  Copyright © 2020 Ray Wenderlich. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
 func gameAlert(_ result: (points: Int, message: String), completion: @escaping () -> Void) {
    let message = "You scored \(result.points) points"
    let alert = UIAlertController(title: result.message, message: message, preferredStyle: .alert)
    let action = UIAlertAction(title: "OK", style: .default, handler: {
        action in
        completion()
    })

    alert.addAction(action)
    self.present(alert, animated: true, completion: nil)
}
}
