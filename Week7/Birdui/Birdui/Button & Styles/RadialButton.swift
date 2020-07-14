//
//  RadialButton.swift
//  Birdui
//
//  Created by Franklin Byaruhanga on 08/07/2020.
//  Copyright © 2020 Razeware. All rights reserved.
//

import SwiftUI

struct RadialButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .font(.title)
            .background(Color.orange.opacity(configuration.isPressed ? 0.5 : 1))
            .clipShape(Circle())
            .foregroundColor(.white)
    }
}

struct RadialButton {
    let label: String
    let image: Image
    let action: () -> Void
}

struct RadialMenu: View {
    @State private var isExpanded = false
    @State private var isShowingSheet = false

    let title: String
    let closedImage: Image
    let openImage: Image
    let buttons: [RadialButton]
    var direction = Angle(degrees: 360)
    var range = Angle(degrees: 90)
    var distance = 100.0
    var animation = Animation.default

    var body: some View {
        ZStack {

            Button(action: {
                if UIAccessibility.isVoiceOverRunning {
                    self.isShowingSheet.toggle()
                } else {
                    self.isExpanded.toggle()
                }
            }) {
                isExpanded ? openImage : closedImage
            }
            .accessibility(label: Text(title))

            ForEach(0..<buttons.count, id: \.self) { i in
                Button(action: {
                    self.buttons[i].action()
                    self.isExpanded.toggle()
                }) {
                    self.buttons[i].image
                }
                .accessibility(hidden: self.isExpanded == false)
                .accessibility(label: Text(self.buttons[i].label))
                .offset(self.offset(for: i))
            }
            .opacity(isExpanded ? 1 : 0)
            .animation(animation)
        }
        .actionSheet(isPresented: $isShowingSheet) {
            ActionSheet(title: Text(title), message: nil, buttons:
                buttons.map { btn in
                    ActionSheet.Button.default(Text(btn.label), action: btn.action)
                    } + [.cancel()]
            )
        }
    }

    func offset(for index: Int) -> CGSize {
        guard isExpanded else { return .zero }

        let buttonAngle = range.radians / Double(buttons.count - 1)
        let ourAngle = buttonAngle * Double(index)
        let finalAngle = direction - (range / 2) + Angle(radians: ourAngle)

        let finalX = cos(finalAngle.radians - .pi / 2) * distance
        let finalY = sin(finalAngle.radians - .pi / 2) * distance
        return CGSize(width: finalX, height: finalY)
    }
}

struct RadialButtonLabView: View {
    @State var isCreateNewPostShowing = false
    var buttons: [RadialButton] {
        [
            RadialButton(label: "Location", image: Image(systemName: "location"), action: locationTapped),
            RadialButton(label: "Camera", image: Image(systemName: "camera"), action: cameraTapped),
            RadialButton(label: "Photo", image: Image(systemName: "photo"), action: photoTapped)
        ]
    }

    var body: some View {
        ZStack() {
            Color.black
                .edgesIgnoringSafeArea(.all)

            RadialMenu(title: "Attach…", closedImage: Image(systemName: "ellipsis.circle"), openImage: Image(systemName: "multiply.circle.fill"), buttons: buttons, animation: .interactiveSpring(response: 0.4, dampingFraction: 0.6))
                .offset(x: -20, y: -20)
                .buttonStyle(RadialButtonStyle())
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

    func photoTapped() {
        print("Photo tapped")
    }

    func cameraTapped() {
        print("camera tapped")
    }

    func locationTapped() {
        print("location tapped")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        RadialButtonLabView()
    }
}
