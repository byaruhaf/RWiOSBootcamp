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

extension UIImageView {

}


class CacheManager {
    static var imageDictionary = [String:Data]()
    static func saveImageToCache(_ url:String,imageData:Data) {
        imageDictionary[url] = imageData
    }
}

//if let imageURL = article.urlToImage {
//
//    if CacheManager.imageDictionary[imageURL] == nil {
//
//        if let url = URL(string: imageURL) {
//            DispatchQueue.global().async { [weak self] in
//                if let data = try? Data(contentsOf: url) {
//                    if let image = UIImage(data: data) {
//                        DispatchQueue.main.async {
//                            if self?.articleToDisplay?.urlToImage == article.urlToImage {
//                                self?.articleImage.image = image
//                                UIView.animate(withDuration: 0.6, delay: 0, options: .curveEaseOut, animations: {
//                                    self?.articleImage.alpha = 1
//                                }, completion: nil)
//
//                            }
//                        }
//                        CacheManager.saveImageToCache(imageURL, imageData: data)
//                    }
//                }
//            }
//        }
//    } else {
//        DispatchQueue.main.async {
//            self.articleImage.image = UIImage(data: CacheManager.imageDictionary[imageURL]!)
//            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
//                self.articleImage.alpha = 1
//            }, completion: nil)
//        }
//    }
//}
