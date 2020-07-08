//
//  HomeTopView.swift
//  Birdui
//
//  Created by Franklin Byaruhanga on 09/07/2020.
//  Copyright © 2020 Razeware. All rights reserved.
//

import SwiftUI

struct HomeTopView: View {
    @State var isCreateNewPostShowing = false
    var posts:PostViewModel
    var body: some View {
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

                Button(action: {
                    self.isCreateNewPostShowing.toggle()
                }) {
                    Text("Create New Post")
                }
                .padding(.trailing)
                .sheet(isPresented: self.$isCreateNewPostShowing) {
                    NewPostView(postHandler: self.posts)
                }.buttonStyle(AddPostButton())

            }
        }
    }
}


struct HomeTopView_Previews: PreviewProvider {
    static var previews: some View {
        HomeTopView(posts: PostViewModel())
    }
}
