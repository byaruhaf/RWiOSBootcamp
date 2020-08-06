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
            RadialButton(label: "Location", image: Image(systemName: "location"), action: locationTapped),
            RadialButton(label: "Camera", image: Image(systemName: "camera.viewfinder"), action: cameraTapped),
            RadialButton(label: "Photo", image: Image(systemName: "photo"), action: photoTapped)
        ]
    }

    var body: some View {
        VStack {
//        HStack {
//            Spacer()
            RadialMenu(title: "Attach…", closedImage: Image(systemName: "camera.on.rectangle.fill"), openImage: Image(systemName: "multiply.circle.fill"), buttons: buttons, animation: .interactiveSpring(response: 0.4, dampingFraction: 0.6), openAction: openActionTapped, closeAction: closeActionTapped)
                .buttonStyle(RadialButtonStyle())
//            Spacer()
//        }
    }
    }

    func photoTapped() {
        print("Hello, photoTapped!")
        mixerViewModel.addMove()
        mixerViewModel.addResize()
    }

    func cameraTapped() {
        print("Hello, cameraTapped!")
        mixerViewModel.addColorChange()
    }

    func locationTapped() {
        print("Hello, locationTapped!")
        mixerViewModel.addFadeIn()
    }

    func openActionTapped() {
        print("Hello, openAction!")
    }
    func closeActionTapped() {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "refresh"), object: nil)
        print("Hello, closeAction!")
    }

}

//struct MixerMenuButton_Previews: PreviewProvider {
//    static var previews: some View {
//        MixerMenuButton(mixerViewModel: <#MixerViewModel#>)
//    }
//}
