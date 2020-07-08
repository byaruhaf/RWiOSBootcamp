//
//  CoolButton.swift
//  Birdui
//
//  Created by Franklin Byaruhanga on 08/07/2020.
//  Copyright © 2020 Razeware. All rights reserved.
//

import SwiftUI

struct CoolButton: ButtonStyle {

    let backgroundColor = Color(hue: 0.08, saturation: 0.76, brightness: 0.99)
    let diameter: CGFloat = 60

    func makeBody(configuration: Self.Configuration) -> some View {

        let trimColor: Color = configuration.isPressed ? .yellow : .white

        return ZStack {

            Circle()
                .fill(backgroundColor)

            VStack(spacing: 12) {

                Image(systemName: "rectangle.stack.badge.plus")
                    .font(.system(size: 30))

            }.foregroundColor(trimColor)

        }.frame(width: diameter, height: diameter)
            .overlay(Circle()
                .stroke(trimColor, lineWidth: 2)
                .padding(4))
    }
}


struct SpicyButtonStyle: ButtonStyle {

    let trimColor = Color(hue: 0.08, saturation: 0.76, brightness: 0.99)
    let radius: CGFloat = 50

    func makeBody(configuration: Self.Configuration) -> some View {

        ZStack {
            RoundedRectangle(cornerRadius: radius)
                .fill(Color.white)

            HStack {
                configuration.label
                    .foregroundColor(configuration.isPressed ? .black : trimColor)
                    .font(.system(.title))
            }

        }.frame(height: 64)
            .overlay(RoundedRectangle(cornerRadius: radius)
                .stroke(trimColor, lineWidth: 4))
    }
}

struct ButtonLabView: View {

    var labelContent: some View {
        Text("Hello world!")
    }

    var body: some View {

        VStack(spacing: 32) {
            Button(action: {}) {
                labelContent
            }.buttonStyle(CoolButton())
            Button(action: {}) {
                labelContent
            }.buttonStyle(SpicyButtonStyle())
        }.padding()


    }
}

struct CoolButton_Previews: PreviewProvider {
    static var previews: some View {
        ButtonLabView()
    }
}
