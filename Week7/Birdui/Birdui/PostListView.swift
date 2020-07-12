//
//  PostListView.swift
//  Birdui
//
//  Created by Audrey Tam on 4/7/20.
//  Copyright © 2020 Razeware. All rights reserved.
//

import SwiftUI

struct PostListView: View {
    @ObservedObject var postViewModel = PostViewModel()
    @State var isCreateNewPostShowing = false
    var body: some View {
        VStack {
            ZStack(alignment: .bottomTrailing){
                NavigationView {
                    VStack(alignment: .leading, spacing: 30.0) {
                        List {
                            ForEach(postViewModel.posts, id: \.id) { post in
                                PostView(post: post)
                            }
                            .onDelete(perform:postViewModel.deletePost(at:))
                        }
                    }
                    .navigationBarTitle("HOME")
                    .navigationBarItems(trailing:
                            NavSortView(posts: postViewModel)
                    )
                }

                Button(action: {
                    self.isCreateNewPostShowing.toggle()
                }) {
                    Text("Create New Post")
                }
                .padding(.trailing)
                .sheet(isPresented: self.$isCreateNewPostShowing) {
                    NewPostView(postHandler: self.postViewModel)
                }.buttonStyle(AddPostButton())
            }
        }
    }
}

struct PostListView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            PostListView()
                .previewDisplayName("Post List's")
                .background(Color(.systemBackground))
                .environment(\.colorScheme, .dark)
                .previewDisplayName("Post List Dark Mode")

            PostListView()
                .previewDisplayName("Post List's")
                .background(Color(.systemBackground))
                .previewDisplayName("Post List Dark Mode")

        }
    }
}

