//
//  MixerViewModel.swift
//  Mixer
//
//  Created by Franklin Byaruhanga on 05/08/2020.
//  Copyright © 2020 Franklin Byaruhanga. All rights reserved.
//

import Combine
import SwiftUI

class MixerViewModel: ObservableObject {
   @Published var viewAnimations = [Animator]()

    func addFadeIn() {
        viewAnimations.append(.fadeIn())
    }

    func addResize() {
        viewAnimations.append(.resize(to: CGSize(width: 150, height: 150)))
    }

    func addMove() {
        viewAnimations.append(.move())
    }

    func addrotate() {
        viewAnimations.append(.rotate())
    }
    
}
