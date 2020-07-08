//
//  PostListView.swift
//  Birdui
//
//  Created by Audrey Tam on 4/7/20.
//  Copyright © 2020 Razeware. All rights reserved.
//

import SwiftUI

struct PostListView: View {
    @ObservedObject var posts = PostViewModel()
     @State var showingNewPost = false
  var body: some View {
    // TODO: This should look exactly like the Birdie table view,
    // but with only one button.
    VStack {
        VStack(alignment: .leading) {
            HStack {
                Image("mascot_swift-badge")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                Spacer()
                Text("HOME")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                 Spacer()
                 Spacer()
            }
            Button(action: {
                self.showingNewPost.toggle()
            }) {
                Text("Create New Post")
            }.sheet(isPresented: self.$showingNewPost) {
                NewPostView(postHandler: self.posts)
            }

        }
        ScrollView {
            VStack(alignment: .leading, spacing: 30.0) {
                ForEach(posts.posts, id: \.id) { post in
                   PostView(post: post)
            }

            }
            .padding(.horizontal)
        }
    }
}
}

struct PostListView_Previews: PreviewProvider {
  static var previews: some View {
    PostListView()
  }
}