//
//  AddPostButtonStyle.swift
//  Birdui
//
//  Created by Franklin Byaruhanga on 08/07/2020.
//  Copyright © 2020 Razeware. All rights reserved.
//

import SwiftUI

struct AddPostButtonStyle : ButtonStyle {
    let diameter: CGFloat = 60

    func makeBody(configuration: Self.Configuration) -> some View {

        let trimColor: Color = configuration.isPressed ? .yellow : .white

        return ZStack {

            Circle()
                .fill(GradientBack.linear)

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




struct AddPostButtonLabView: View {

    var labelContent: some View {
        Text("Hello world!")
    }

    var body: some View {

        VStack(spacing: 32) {
            Button(action: {}) {
                labelContent
            }.buttonStyle(AddPostButtonStyle())
        }.padding()


    }
}

struct AddPostButton_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            AddPostButtonLabView()
                .previewLayout(PreviewLayout.sizeThatFits)
                .padding()
                .background(Color(.systemBackground))
                .environment(\.colorScheme, .dark)
                .previewDisplayName("Button Dark Mode preview")
        }
    }
}
