//
//  NewPostView.swift
//  Birdui
//
//  Created by Audrey Tam on 4/7/20.
//  Copyright © 2020 Razeware. All rights reserved.
//

import SwiftUI

struct NewPostView: View {
  var postHandler: PostViewModel
  @Environment(\.presentationMode) var presentationMode
  
  @State var username: String = ""
  @State var postText: String = ""
  @State var showImagePicker = false
  @State var uiImage: UIImage?
  
  let imageSize: CGFloat = 200
  
  var body: some View {
    VStack {
      Text("New Post")
        .font(.headline)
      Form {
        TextField("Username", text: $username)
        TextField("Post text", text: $postText)
        HStack {
            Spacer()
            Button(action: {
                self.showImagePicker = true
            }) {
                Image(systemName: "camera").font(.system(size: 25, weight: .regular)).foregroundColor( Color(hue: 0.08, saturation: 0.76, brightness: 0.99))
            }
        }

        if uiImage != nil {
            Image(uiImage: uiImage!)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: imageSize, height: imageSize)
        }

      }
      HStack {
        Button("Cancel") {
          self.presentationMode.wrappedValue.dismiss()
        }
        .buttonStyle(SpicyButtonStyle())
        Spacer()
            .padding(.horizontal)
        Button("Post") {
          self.postHandler.addPost(post: MediaPost(textBody: self.postText, userName: self.username, timestamp: Date(), uiImage: self.uiImage))
          self.presentationMode.wrappedValue.dismiss()
        }
            .buttonStyle(SpicyButtonStyle())
        .disabled(username.isEmpty && postText.isEmpty)
      }
      .padding()
    }
    .sheet(isPresented: $showImagePicker) {
      // TODO: Show ImagePicker
        ImagePicker(image: self.$uiImage)
    }
  }
}

struct NewPostView_Previews: PreviewProvider {
  static var previews: some View {
    NewPostView(postHandler: PostViewModel())
  }
}
