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
  @Published var posts: [PostAble] = []
@Published var isSortedByNewest: Bool
  
  init() {
    let post1 = MediaPost(textBody: "Kirk, Spock, Bones, Sulu, Chekov and Uhura go back to the future (or is it forward to the past?) as the Federation gets repainted, retooled and rebooted", userName: "Jay", timestamp: Date(timeIntervalSinceNow: -123456), uiImage: UIImage(named: "StarTrek"), location: CLLocationCoordinate2DMake(36.7783, 119.4179))
    let post2 = MediaPost(textBody: "If you haven't already seen the musical event of the summer... JUST YOU WAIT. Hamilton is now streaming", userName: "Audrey", timestamp: Date(timeIntervalSinceNow: -9876), uiImage: UIImage(named:  "Hamilton_Disney") ,location: CLLocationCoordinate2DMake(37.8136,144.9631))
    let post3 = MediaPost(textBody: "Apple Pay really needs a way to deal with in person transactions that doesn’t require giving them your Apple ID (which they can then text / spam later). Single use QR code with 24hr contact window, some kinda boop, something.", userName: "Bhagat", timestamp: Date(timeIntervalSinceNow: -67890), uiImage: nil, location: CLLocationCoordinate2DMake(28.7041,77.1025))
    let post4 = MediaPost(textBody: "Am I the only one who is planning to watch @HamiltonMusical on repeat, all day, during the whole week?", userName: "Jeff", timestamp: Date(timeIntervalSinceNow: -2345), uiImage: nil, location: CLLocationCoordinate2DMake(47.7511,120.7401))
    let repost2 = RetweetMediaPost(userName: "Franklin", timestamp: Date(), post: post2)
    posts = [post1, post2, post3, post4,repost2]
    isSortedByNewest = false
    toggle()
  }
  
  func addPost(post: PostAble) {
      posts.append(post)
    postsSorted()
  }

    func deletePost(at offsets: IndexSet) {
        posts.remove(atOffsets: offsets)
       postsSorted()
    }



    func toggle() {
        isSortedByNewest.toggle()
        postsSorted()
    }

    fileprivate func postsSorted() {
        if isSortedByNewest {
            posts = posts.sorted(by: { $0.timestamp > $1.timestamp })
        } else {
            posts = posts.sorted(by: { $0.timestamp < $1.timestamp })
        }
    }

}
