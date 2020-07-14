//
//  AppDelegate.swift
//  Birdui
//
//  Created by Audrey Tam on 3/7/20.
//  Copyright © 2020 Razeware. All rights reserved.
//

import UIKit
import CoreLocation

protocol PostAble {
    var id:UUID { get }
    var userName: String { get }
     var timestamp: Date { get }
}



struct MediaPost: PostAble, Identifiable {
    let id = UUID()
    let textBody: String?
    let userName: String
    let timestamp: Date
    let uiImage: UIImage?
    var isFavorite:Bool = false
    var location:CLLocationCoordinate2D?
}

struct RetweetMediaPost: PostAble,Identifiable {
    let id = UUID()
    let userName: String
    let timestamp: Date
    let post: MediaPost
}
