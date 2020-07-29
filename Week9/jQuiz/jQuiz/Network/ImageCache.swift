//
//  ImageCache.swift
//  jQuiz
//
//  Created by Jay Strawn on 7/19/20.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//

//https://cdn.dribbble.com/users/1405795/screenshots/4801691/1.jpg
//https://dribbble.com/shots/4801691-Trivia-Game-Logo

import UIKit

// Image Caching using Flyweight Cache Pattern provides in-memory cache only
extension UIImageView {
    func load(imageURL: String,key:String) {
        func saveImageToCache(_ url:String,imageData:Data) {Networking.sharedInstance.imageDictionary[url] = imageData}
        if Networking.sharedInstance.imageDictionary[key] == nil {
//            print("Downloading")
            if let url = URL(string: imageURL) {
                DispatchQueue.global(qos: .userInitiated).async { [weak self] in
                    if let data = try? Data(contentsOf: url) {
                        if let image = UIImage(data: data) {
                            DispatchQueue.main.async {
                                self?.image = image
                            }
                           saveImageToCache(key, imageData: data)
                        }
                    }
                }
            }

        } else {
//             print("Using Cache")
            DispatchQueue.main.async {
                self.image = UIImage(data: Networking.sharedInstance.imageDictionary[key]!)
            }
        }
    }
}

// Better Solution For Real APP
// Image Caching using URLCache provides in-memory and on-disk cache

//extension UIImageView {
//    func load(url: URL, cache: URLCache? = nil) {
//        let cache = cache ?? URLCache.shared
//        let request = URLRequest(url: url)
//        if let data = cache.cachedResponse(for: request)?.data, let image = UIImage(data: data) {
//            self.image = image
//        } else {
//            URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
//                if let data = data, let response = response, ((response as? HTTPURLResponse)?.statusCode ?? 500) < 300, let image = UIImage(data: data) {
//                    let cachedData = CachedURLResponse(response: response, data: data)
//                    cache.storeCachedResponse(cachedData, for: request)
//                    DispatchQueue.main.async {
//                        self.image = image
//                    }
//                }
//            }).resume()
//        }
//    }
//}

