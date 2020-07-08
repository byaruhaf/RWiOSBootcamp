//
//  PostView.swift
//  Birdui
//
//  Created by Audrey Tam on 4/7/20.
//  Copyright © 2020 Razeware. All rights reserved.
//

import SwiftUI

struct PostView: View {
    let post: MediaPost

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image("mascot_swift-badge")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                VStack(alignment: .leading) {
                    Text("\(post.userName)")
                    Text("\(post.timestamp.toString())")
                }
            }
            VStack(alignment: .leading, spacing: -20.0) {
                Text("\(post.textBody!)")
                HStack(alignment: .top) {
                    if post.uiImage  != nil {
                        Spacer()
                        Image(uiImage: post.uiImage ?? UIImage())
                            .resizable()
                            .scaledToFit()
                            .frame(width: 200.0,height:200.0)
                        Spacer()
                    } else {
                        EmptyView()
                    }
                }
            }
        }
    }
}

struct PostView_Previews: PreviewProvider {
    static var previews: some View {
        PostView(post: MediaPost(textBody: "Went to the Aquarium today :]",
                                 userName: "Audrey", timestamp: Date(timeIntervalSinceNow: -9876),
                                 uiImage: UIImage(named: "octopus")))
    }
}
