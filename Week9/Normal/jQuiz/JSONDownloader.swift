//
//  JSONDownloader.swift
//  jQuiz
//
//  Created by Franklin Byaruhanga on 22/07/2020.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//

import Foundation
class JSONDownloader {
    let session: URLSession

    init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
    }

    convenience init() {
        self.init(configuration: .default)
    }

    typealias JSON = [String: AnyObject]
    typealias JSONTaskCompletionHandler = (JSON?, JServiceError?) -> Void

    func jsonTask(with request: URLRequest, completionHandler completion: @escaping JSONTaskCompletionHandler) -> URLSessionDataTask {
        let task = session.dataTask(with: request) { data, response, error in

            guard let httpResponse = response as? HTTPURLResponse else {
                completion(nil, .requestFailed)
                return
            }

            if httpResponse.statusCode == 200 {
                if let data = data {
                    do {
                        let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: AnyObject]
                        completion(json, nil)
                    } catch {
                        completion(nil, .jsonConversionFailure)
                    }
                } else {
                    completion(nil, .invalidData)
                }
            } else {
                completion(nil, .responseUnsuccessful)
            }

        }

        return task
    }
}
