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

    func addColorChange() {
        viewAnimations.append(.colorChange())
    }

    func addResize() {
        viewAnimations.append(.resize(to: CGSize(width: 200, height: 200)))
    }

    func addMove() {
        viewAnimations.append(.move())
    }
    
}
