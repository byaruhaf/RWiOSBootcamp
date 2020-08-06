//
//  MixerMenuButton.swift
//  Mixer
//
//  Created by Franklin Byaruhanga on 05/08/2020.
//  Copyright © 2020 Franklin Byaruhanga. All rights reserved.
//

import SwiftUI

struct MixerMenuButton: View {
     @ObservedObject var mixerViewModel: MixerViewModel
      @State private var isExpanded = false
    var buttons: [RadialButton] {
        [
            RadialButton(label: "eye.fill", image: Image(systemName: "eye.fill"), action: fadeInTapped),
            RadialButton(label: "Resize", image: Image(systemName: "arkit"), action: resizeTapped),
            RadialButton(label: "Move", image: Image(systemName: "arrow.swap"), action: moveTapped)
        ]
    }

    var body: some View {
        VStack {
//        HStack {
            Spacer()
            RadialMenu(title: "Attach…", closedImage: Image(systemName: "play.fill"), openImage: Image(systemName: "playpause.fill"), buttons: buttons, animation: .interactiveSpring(response: 0.4, dampingFraction: 0.6), openAction: openActionTapped, closeAction: closeActionTapped)
                .buttonStyle(RadialButtonStyle())
//            Spacer()
//        }
        }
    }

    func moveTapped() {
        print("Hello, photoTapped!")
        mixerViewModel.addMove()
    }

    func resizeTapped() {
        print("Hello, cameraTapped!")
        mixerViewModel.addResize()
    }

    func fadeInTapped() {
        print("Hello, locationTapped!")
        mixerViewModel.addFadeIn()
        mixerViewModel.addrotate()

    }

    func openActionTapped() {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "reset"), object: nil)
        print("Hello, openAction!")
    }
    func closeActionTapped() {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "perform"), object: nil)
        print("Hello, closeAction!")
    }

}

struct MixerMenuButton_Previews: PreviewProvider {
    static var previews: some View {
        MixerMenuButton(mixerViewModel: MixerViewModel())
    }
}
