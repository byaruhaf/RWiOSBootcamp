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
import Combine

extension UIImageView {
    func load(url: URL, cache: URLCache? = nil) {
        let cache = cache ?? URLCache.shared
        let request = URLRequest(url: url)
        //        let imageCancellable: Cancellable
        if let data = cache.cachedResponse(for: request)?.data, let image = UIImage(data: data) {
            self.image = image
        } else {
            //            URLSession.shared.dataTaskPublisher(for: url)
            //                   .map { (data, response) -> UIImage? in
            //                    let cachedData = CachedURLResponse(response: response, data: data)
            //                    cache.storeCachedResponse(cachedData, for: request)
            //                    return UIImage(data: data) }
            //                .catch { error in return Just(nil) }
            //                .handleEvents(receiveOutput: {[unowned self] image in
            //                    guard let image = image else { return }
            //                    self.image = image
            //                })
            //                .receive(on: DispatchQueue.main)
            //            .assign(to: \.image, on: self)
            URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
                if let data = data, let response = response, ((response as? HTTPURLResponse)?.statusCode ?? 500) < 300, let image = UIImage(data: data) {
                    let cachedData = CachedURLResponse(response: response, data: data)
                    cache.storeCachedResponse(cachedData, for: request)
                    DispatchQueue.main.async {
                        self.image = image
                    }
                }
            }).resume()
        }
    }
}
