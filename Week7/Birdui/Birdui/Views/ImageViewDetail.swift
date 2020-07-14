//
//  ImageViewDetail.swift
//  Birdui
//
//  Created by Franklin Byaruhanga on 10/07/2020.
//  Copyright © 2020 Razeware. All rights reserved.
//

import SwiftUI

struct ImageViewDetail: View {
     @Environment(\.presentationMode) var presentationMode
    var image: UIImage
    var body: some View {
        Image(uiImage: image)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .onTapGesture(count: 2) {
                self.presentationMode.wrappedValue.dismiss()
        }
    }
}

struct ImageViewDetail_Previews: PreviewProvider {
    static var previews: some View {
        ImageViewDetail(image: UIImage(named: "octopus")!)
            .previewLayout(PreviewLayout.sizeThatFits)
            .padding()
            .background(Color(.systemBackground))
            .environment(\.colorScheme, .dark)
    }
}
