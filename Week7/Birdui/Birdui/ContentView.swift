//
//  ContentView.swift
//  Birdui
//
//  Created by Audrey Tam on 3/7/20.
//  Copyright © 2020 Razeware. All rights reserved.
//

import SwiftUI


struct ContentView: View {
  let postHandler = MediaPostsHandler()
  @State var isPresented: Bool = false
  var body: some View {
    postHandler.getPosts()
    
    return VStack(alignment: .leading) {
      ZStack {
        HStack {
          Image("mascot_swift-badge")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 50, height: 50, alignment: .leading)
          Spacer()
        }
        .padding(.leading, 20)
          .frame(maxWidth: .infinity)
        Text("Home")
          .frame(alignment: .center)
      }
        .frame(maxWidth: .infinity)
//      .padding()
      HStack {
        Button("Create Text Post") {
          self.isPresented.toggle()
        }
        Spacer()
        Text("Create Image Post")
      }
      .padding(.leading, 20)
      .padding(.trailing, 20)
      List(postHandler.mediaPosts) { post in 
        PostContentView(post: post)
      }
    }
    .sheet(isPresented: $isPresented) {
      NewPostView(postHandler: self.postHandler, isPresented: self.$isPresented)
    }
    
  }
}

struct PostContentView: View {
  let post: MediaPost
  
  var body: some View {
    let dateFormat = DateFormatter()
    dateFormat.dateFormat = "d MMM, HH:mm"
    
    return VStack {
      VStack(alignment: .leading) {
        HStack {
          MascotImage(size: 50)
          VStack(alignment: .leading) {
            Text(post.userName)
            Text(dateFormat.string(from: post.timestamp))
          }
        }
        Text(post.textBody!)
      }
      .frame(maxWidth: .infinity, alignment: .leading)
      if post.imageName != nil {
      Image(post.imageName!)
        .resizable()
        .aspectRatio(contentMode: .fit)
        .frame(width: 100, height: 100)
      }
    }
  }
}

//struct TextContentView_Previews: PreviewProvider {
//    static var previews: some View {
//      TextContentView(post: TextPost(textBody: "This is my favorite social media app! This is my favorite social media app! This is my favorite social media app!", userName: "Jeff", timestamp: Date(timeIntervalSinceNow: -2345)))
//    }
//}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
