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
     @State var favColor = Color.primary

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image("mascot_swift-badge")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                VStack(alignment: .leading) {
                    Text("\(post.userName)")
                        .fontWeight(.bold)
                    Text("\(post.timestamp.toString())")
                        .font(.caption)
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

                HStack {
                    if post.location != nil {
                        Text("Lat:\(post.location!.latitude): Long:\(post.location!.longitude)")
                    }
                    Spacer()
                    Image(systemName: "heart.fill").font(.system(size: 16, weight: .regular)).foregroundColor(favColor)
                        .onTapGesture {
                            self.post.isFavorite.toggle()
                            if self.post.isFavorite {
                                self.favColor = Color.red
                            }else{
                                self.favColor = Color.primary
                            }
                    }
                }

                // code to add location.

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
        .padding(.horizontal)
        .background(Color.quaternaryLabel)
        .cornerRadius(/*@START_MENU_TOKEN@*/10.0/*@END_MENU_TOKEN@*/)
            //        .border(Color.quaternaryLabel, width: 4)
            .shadow(color: .quaternaryLabel, radius: 30, x: 20, y: 20)
    }
}

struct PostView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            PostView(post: MediaPost(textBody: "Went to the Aquarium today :]",
                                     userName: "Audrey", timestamp: Date(timeIntervalSinceNow: -9876),
                                     uiImage: UIImage(named: "octopus"), location: CLLocationCoordinate2DMake(37.8136,144.9631)))
                .previewLayout(PreviewLayout.sizeThatFits)
                .padding()
                .previewDisplayName("Post With Image preview")

            PostView(post: MediaPost(textBody: "Went to the Aquarium today :]",
                                     userName: "Audrey", timestamp: Date(timeIntervalSinceNow: -9876), uiImage: nil, location: CLLocationCoordinate2DMake(37.8136,144.9631)))
                .previewLayout(PreviewLayout.sizeThatFits)
                .padding()
                .previewDisplayName("Post Without Image preview")

            PostView(post: MediaPost(textBody: "Went to the Aquarium today :]",
                                     userName: "Audrey", timestamp: Date(timeIntervalSinceNow: -9876),
                                     uiImage: UIImage(named: "octopus"), location: CLLocationCoordinate2DMake(37.8136,144.9631)))
                .previewLayout(PreviewLayout.sizeThatFits)
                .padding()
                .background(Color(.systemBackground))
                .environment(\.colorScheme, .dark)
                .previewDisplayName("Post With Image Dark Mode preview")

            PostView(post: MediaPost(textBody: "Went to the Aquarium today :]",
                                     userName: "Audrey", timestamp: Date(timeIntervalSinceNow: -9876), uiImage: nil, location: CLLocationCoordinate2DMake(37.8136,144.9631)))
                .previewLayout(PreviewLayout.sizeThatFits)
                .padding()
                .background(Color(.systemBackground))
                .environment(\.colorScheme, .dark)
                .previewDisplayName("Post Without Image Dark Mode preview")

            
        }
    }
}
