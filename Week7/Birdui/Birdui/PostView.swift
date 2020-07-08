//
//  PostView.swift
//  Birdui
//
//  Created by Audrey Tam on 4/7/20.
//  Copyright © 2020 Razeware. All rights reserved.
//

import SwiftUI
import CoreLocation

struct PostView: View {
     @State var post: MediaPost

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
            VStack(alignment: .leading, spacing: 0.0) {
                Text("\(post.textBody!)")
                    .padding(.bottom)
                HStack(alignment: .top) {
                    if post.uiImage  != nil {
                        Spacer()
                        Image(uiImage: post.uiImage ?? UIImage())
                            .resizable()
                            .padding(.vertical, -40.0)
                            .scaledToFit()
                            .frame(width: 200.0,height:200.0)
                        Spacer()
                    } else {
                        EmptyView()
                    }
                }
//                Text("\(post.location!.latitude.description),\(post.location!.longitude.description)")
// code to add fav button. 
//                HStack() {
//                    Button(action: {
//                        post.isFavorite.toggle()
//                    }) {
//                        if post.isFavorite {
//                            Image(systemName: "star.fill")
//                                .foregroundColor(Color.yellow)
//                        } else {
//                            Image(systemName: "star")
//                                .foregroundColor(Color.gray)
//                        }
//
//                    }
//                }
            }
            Rectangle()
                .frame(height: 2)
                .foregroundColor(Color(UIColor.separator))
        }
    }
}

struct PostView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            PostView(post: MediaPost(textBody: "Went to the Aquarium today :]",
                                     userName: "Audrey", timestamp: Date(timeIntervalSinceNow: -9876),
                                 uiImage: UIImage(named: "octopus"), location: CLLocationCoordinate2DMake(37.8136,144.9631)))
            PostView(post: MediaPost(textBody: "Went to the Aquarium today :]",
                                     userName: "Audrey", timestamp: Date(timeIntervalSinceNow: -9876), uiImage: nil, location: CLLocationCoordinate2DMake(37.8136,144.9631)))
        }
    }
}
