//
//  SortPostButton.swift
//  Birdui
//
//  Created by Franklin Byaruhanga on 09/07/2020.
//  Copyright © 2020 Razeware. All rights reserved.
//


import SwiftUI

struct SortPostButton: ButtonStyle {

    //    let backgroundColor = Color(hue: 0.08, saturation: 0.76, brightness: 0.99)
    let diameter: CGFloat = 40

    func makeBody(configuration: Self.Configuration) -> some View {

        let trimColor: Color = configuration.isPressed ? .yellow : .white

        return ZStack {

            Circle()
                .fill(GradientBack.linear)

            VStack(spacing: 12) {

                Image(systemName: "arrow.up.arrow.down")
                    .font(.system(size: 20))
                 .accessibility(label: Text("Sort Posts By Date"))
            }.foregroundColor(trimColor)

        }.frame(width: diameter, height: diameter)
            .overlay(Circle()
                .stroke(trimColor, lineWidth: 2)
                .padding(4))
    }
}




struct SortPostButtonLabView: View {

    var labelContent: some View {
        Text("Hello world!")
    }

    var body: some View {

        VStack(spacing: 32) {
            Button(action: {}) {
                labelContent
            }.buttonStyle(SortPostButton())
        }.padding()


    }
}

struct SortPostButton_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SortPostButtonLabView()
                .previewLayout(PreviewLayout.sizeThatFits)
                .padding()
                .background(Color(.systemBackground))
                .previewDisplayName("Button preview")
            SortPostButtonLabView()
                .previewLayout(PreviewLayout.sizeThatFits)
                .padding()
                .background(Color(.systemBackground))
                .environment(\.colorScheme, .dark)
                .previewDisplayName("Button Dark Mode preview")
        }
    }
}
