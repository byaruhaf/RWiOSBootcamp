//
//  NewRetweetPostView.swift
//  Birdui
//
//  Created by Franklin Byaruhanga on 14/07/2020.
//  Copyright © 2020 Razeware. All rights reserved.
//

import SwiftUI
import CoreLocation

struct NewRetweetPostView: View {
    var postHandler: PostViewModel
    @State var post: MediaPost
    @Environment(\.presentationMode) var presentationMode

    @State var username: String = ""
    @State private var showSheet: Bool = false
    var body: some View {
        VStack {

            Form {
                TextField("Username", text: $username)
            }
            .onTapGesture {
                // dismiss the keyboard once form is tapped.
                self.hideKeyboard()
            }

            Spacer()
            HStack {
                Button("Cancel") {
                    self.presentationMode.wrappedValue.dismiss()
                }
                .buttonStyle(ChoiceButtonStyle())
                Spacer()
                    .padding(.horizontal)
                Button("Re-Post") {
                    self.postHandler.addPost(post: RetweetMediaPost(userName: self.username, timestamp: Date(), post: self.post))
                    self.presentationMode.wrappedValue.dismiss()
                }
                .buttonStyle(ChoiceButtonStyle())
                .disabled(username.isEmpty)
            }
            .padding()
        }
        }
    }


struct NewRetweetPostView_Previews: PreviewProvider {
    static var previews: some View {
        NewRetweetPostView(postHandler: PostViewModel(), post: MediaPost(textBody: "Kirk, Spock, Bones, Sulu, Chekov and Uhura go back to the future (or is it forward to the past?) as the Federation gets repainted, retooled and rebooted",
                                                                         userName: "Audrey", timestamp: Date(timeIntervalSinceNow: -9876),
                                                                         uiImage: UIImage(named: "octopus"), location: CLLocationCoordinate2DMake(37.8136,144.9631)))
    }
}
