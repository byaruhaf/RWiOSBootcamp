//
//  PostViewModel.swift
//  Birdui
//
//  Created by Audrey Tam on 4/7/20.
//  Copyright © 2020 Razeware. All rights reserved.
//

import SwiftUI
import CoreLocation

class PostViewModel: ObservableObject {
  @Published var posts: [MediaPost] = []
@Published var isSortedByNewest: Bool = true
  
  init() {
    let post1 = MediaPost(textBody: "I love debugging software!", userName: "Jay", timestamp: Date(timeIntervalSinceNow: -123456), uiImage: UIImage(named: "chop"), location: CLLocationCoordinate2DMake(36.7783, 119.4179))
    let post2 = MediaPost(textBody: "Went to the Aquarium today :]", userName: "Audrey", timestamp: Date(timeIntervalSinceNow: -9876), uiImage: UIImage(named:  "octopus") ,location: CLLocationCoordinate2DMake(37.8136,144.9631))
    let post3 = MediaPost(textBody: "Hello World!", userName: "Bhagat", timestamp: Date(timeIntervalSinceNow: -67890), uiImage: nil, location: CLLocationCoordinate2DMake(28.7041,77.1025))
    let post4 = MediaPost(textBody: "This is my favorite social media app! This is my favorite social media app! This is my favorite social media app!", userName: "Jeff", timestamp: Date(timeIntervalSinceNow: -2345), uiImage: nil, location: CLLocationCoordinate2DMake(47.7511,120.7401))
    
    posts = [post1, post2, post3, post4].sorted(by: { $0.timestamp < $1.timestamp })
  }
  
  func addPost(post: MediaPost) {
      posts.append(post)
    if isSortedByNewest {
        posts = posts.sorted(by: { $0.timestamp < $1.timestamp })
    } else {
        posts = posts.sorted(by: { $0.timestamp > $1.timestamp })
    }
  }

    func deletePost(at offsets: IndexSet) {
        posts.remove(atOffsets: offsets)
        if isSortedByNewest {
            posts = posts.sorted(by: { $0.timestamp < $1.timestamp })
        } else {
            posts = posts.sorted(by: { $0.timestamp > $1.timestamp })
        }
    }

    func toggle() {
        isSortedByNewest.toggle()
        if isSortedByNewest {
            posts = posts.sorted(by: { $0.timestamp < $1.timestamp })
        } else {
  posts = posts.sorted(by: { $0.timestamp > $1.timestamp })
        }

    }

}
