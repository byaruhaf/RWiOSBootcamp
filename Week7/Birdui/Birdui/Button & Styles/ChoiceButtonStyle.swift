//
//  ChoiceButtonStyle.swift
//  Birdui
//
//  Created by Franklin Byaruhanga on 09/07/2020.
//  Copyright © 2020 Razeware. All rights reserved.
//

import SwiftUI

struct ChoiceButtonStyle: ButtonStyle {

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



struct ChoiceButtonLabView: View {

    var labelContent: some View {
        Text("Hello world!")
    }

    var body: some View {

        VStack(spacing: 32) {
            Button(action: {}) {
                labelContent
            }.buttonStyle(ChoiceButtonStyle())
        }.padding()


    }
}

struct ChoiceButton_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ChoiceButtonLabView()
                .previewLayout(PreviewLayout.sizeThatFits)
                .padding()
                .background(Color(.systemBackground))
                .environment(\.colorScheme, .dark)
                .previewDisplayName("Button Dark Mode preview")
        }
    }
}
