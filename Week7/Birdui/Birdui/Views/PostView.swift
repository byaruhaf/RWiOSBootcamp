//
//  PostView.swift
//  Birdui
//
//  Created by Audrey Tam on 4/7/20.
//  Copyright © 2020 Razeware. All rights reserved.
//

import SwiftUI
import UIKit
import CoreLocation

struct PostView: View {
    @State var post: MediaPost
    @State var favColor = Color.primary
    @State var selectedPost: MediaPost?
    @State var isCreateNewRePostShowing = false
    var postHandler: PostViewModel

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "person.circle") .accessibility(label: Text("Profile Image")).font(.system(size: 40, weight: .regular)).foregroundColor(Color.orange)
                    .frame(width: 50, height: 50)
                VStack(alignment: .leading) {
                    Text("\(post.userName)")
                        .fontWeight(.bold)
                    Text("\(post.timestamp.toString())")
                        .font(.caption)
                }
            }
            VStack(alignment: .leading, spacing: 10.0) {
                Text("\(post.textBody!)")
                    .fixedSize(horizontal: false, vertical: true)
                HStack(alignment: .top) {
                    if post.uiImage  != nil {
                        Spacer()
                        Image(uiImage: post.uiImage ?? UIImage())
                            .resizable()
                            .scaledToFit()
                            .frame(width: 300.0,height:300.0)
                            .clipped()
                            .accessibility(label: Text("user posted Image"))
                            .onTapGesture(count: 2) {
                                self.selectedPost = self.post
                        }
                        Spacer()
                    } else {
                        EmptyView()
                    }
                }.sheet(item: $selectedPost) {
                    ImageViewDetail(image: $0.uiImage!)
                }

                HStack {
                    if post.location != nil {
                        Text("Lat:\(Int(post.location!.latitude)): Long:\(Int(post.location!.longitude))")
                            .font(.caption)
                            .foregroundColor(Color.orange)
                            .accessibility(hint: Text("User Location."))
                    }
                    Spacer()

                           Image(systemName: "arrow.2.squarepath").font(.system(size: 16, weight: .regular)).foregroundColor(Color.orange)
                            .onTapGesture {
                                self.isCreateNewRePostShowing = true
                           }
                    .padding(.trailing)
                    .sheet(isPresented: self.$isCreateNewRePostShowing) {
                        NewRetweetPostView(postHandler: self.postHandler, post: self.post)
                    }

                    Spacer()
                    Image(systemName: "heart.fill").font(.system(size: 16, weight: .regular)).foregroundColor(favColor)
                        .accessibility(addTraits: .isButton)
                        .accessibility(label: Text("Mark posts as Favorite"))
                        .onTapGesture {
                            self.post.isFavorite.toggle()
                            if self.post.isFavorite {
                                self.favColor = Color.red
                            }else{
                                self.favColor = Color.primary
                            }
                    }
                }
            }
            Rectangle()
                .frame(height: 2)
                .foregroundColor(Color(UIColor.separator))
        }
        .padding(.horizontal)
        .background(Color.quaternaryLabel)
        .cornerRadius(/*@START_MENU_TOKEN@*/10.0/*@END_MENU_TOKEN@*/)
        .shadow(color: .quaternaryLabel, radius: 30, x: 20, y: 20)
    }
}






struct PostView_Previews: PreviewProvider {
    static var previews: some View {
        Group {

            PostView(post: MediaPost(textBody: "Kirk, Spock, Bones, Sulu, Chekov and Uhura go back to the future (or is it forward to the past?) as the Federation gets repainted, retooled and rebooted",
                                     userName: "Audrey", timestamp: Date(timeIntervalSinceNow: -9876),
                                     uiImage: UIImage(named: "octopus"), location: CLLocationCoordinate2DMake(37.8136,144.9631)), postHandler: PostViewModel())
                .previewLayout(PreviewLayout.sizeThatFits)
                .padding()
                .background(Color(.systemBackground))
                .environment(\.colorScheme, .dark)
                .previewDisplayName("Post With Image Dark Mode preview")

            PostView(post: MediaPost(textBody: "Kirk, Spock, Bones, Sulu, Chekov and Uhura go back to the future (or is it forward to the past?) as the Federation gets repainted, retooled and rebooted",
                                     userName: "Audrey", timestamp: Date(timeIntervalSinceNow: -9876), uiImage: nil, location: CLLocationCoordinate2DMake(37.8136,144.9631)), postHandler: PostViewModel())
                .previewLayout(PreviewLayout.sizeThatFits)
                .padding()
                .background(Color(.systemBackground))
                .environment(\.colorScheme, .dark)
                .previewDisplayName("Post Without Image Dark Mode preview")


        }
    }
}
