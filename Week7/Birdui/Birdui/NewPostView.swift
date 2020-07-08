//
//  NewPostView.swift
//  Birdui
//
//  Created by Audrey Tam on 4/7/20.
//  Copyright © 2020 Razeware. All rights reserved.
//

import SwiftUI
import CoreLocation

struct NewPostView: View {
    var postHandler: PostViewModel
    @Environment(\.presentationMode) var presentationMode

    @State var username: String = ""
    @State var postText: String = ""
    @State var uiImage: UIImage?
    @State var location:CLLocationCoordinate2D?

    let locationFetcher = LocationFetcher()

    @State private var showSheet: Bool = false
    @State private var showImagePicker: Bool = false
    @State private var sourceType: UIImagePickerController.SourceType = .camera

    var buttons: [RadialButton] {
        [
            RadialButton(label: "Location", image: Image(systemName: "location"), action: locationTapped),
            RadialButton(label: "Camera", image: Image(systemName: "camera.viewfinder"), action: cameraTapped),
            RadialButton(label: "Photo", image: Image(systemName: "photo"), action: photoTapped)
        ]
    }

    let imageSize: CGFloat = 300

    var body: some View {
        VStack {
            Text("New Post")
                .font(.headline)
            if uiImage != nil {
                Image(uiImage: uiImage!)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(.leading)
                    .frame(width: imageSize, height: imageSize)
            }
            Form {
                TextField("Username", text: $username)
                TextField("Post text", text: $postText)
            }

            HStack {
                RadialMenu(title: "Attach…", closedImage: Image(systemName: "camera.on.rectangle.fill"), openImage: Image(systemName: "multiply.circle.fill"), buttons: buttons, animation: .interactiveSpring(response: 0.4, dampingFraction: 0.6))
                    .buttonStyle(CustomButtonStyle())
            }
            Spacer()
            HStack {
                Button("Cancel") {
                    self.presentationMode.wrappedValue.dismiss()
                }
                .buttonStyle(ChoiceButtonStyle())
                Spacer()
                    .padding(.horizontal)
                Button("Post") {
                    self.postHandler.addPost(post: MediaPost(textBody: self.postText, userName: self.username, timestamp: Date(), uiImage: self.uiImage))
                    self.presentationMode.wrappedValue.dismiss()
                }
                .buttonStyle(ChoiceButtonStyle())
                .disabled(username.isEmpty && postText.isEmpty)
            }
            .padding()
        }
        .sheet(isPresented: $showImagePicker) {
                ImagePicker(image: self.$uiImage, isShown: self.$showImagePicker, sourceType: self.sourceType)
        }
    }

    func photoTapped() {
        print("photo Tapped")
        self.showImagePicker = true
        self.sourceType = .photoLibrary
    }

    func cameraTapped() {
        print("camera Tapped")
        self.showImagePicker = true
        self.sourceType = .camera
    }

    func locationTapped() {
//        self.locationFetcher.start()
        print("Locaiton Tapped")
//        print("\(locationFetcher.lastKnownLocation)")
    }

}

struct NewPostView_Previews: PreviewProvider {
    static var previews: some View {
        NewPostView(postHandler: PostViewModel())
    }
}
