//
//  Keyboard.swift
//  Birdui
//
//  Created by Franklin Byaruhanga on 10/07/2020.
//  Copyright © 2020 Razeware. All rights reserved.
//

import UIKit
import SwiftUI

extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
