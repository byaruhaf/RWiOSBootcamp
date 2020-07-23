//
//  NetworkingHandler.swift
//  jQuiz
//
//  Created by Jay Strawn on 7/17/20.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//

import Foundation
import Combine

enum APIError: Error, LocalizedError {
    case unknown, apiError(reason: String)

    var errorDescription: String? {
        switch self {
            case .unknown:
                return "Unknown error"
            case .apiError(let reason):
                return reason
        }
    }
}

enum HTTPError: LocalizedError {
    case statusCode
    case post
}


class Networking {
      static let sharedInstance = Networking()

    func loadData() -> AnyPublisher<Clues, Error> {
        let url1 = URL(string: "http://www.jservice.io/api/random")!

        return URLSession.shared.dataTaskPublisher(for: url1)
            .mapError { $0 as Error }
            .map { $0.data }
            .decode(type: Clues.self, decoder: JSONDecoder())
            .tryMap { category in
                guard let categoryID = category.first?.categoryID else { throw HTTPError.post}
                guard let cluesCount = category.first?.category?.cluesCount else { throw HTTPError.post}
                print("\(categoryID)")
                return (categoryID,cluesCount)
        }
        .flatMap { (categoryID,cluesCount) in
            return self.getAllCluesInCategory(for: categoryID, cluesCount: cluesCount)
        }
        .eraseToAnyPublisher()
//        .sink(receiveCompletion: { completion in
//            switch completion {
//                case .finished:
//                    break
//                case .failure(let error):
//                    print(error.localizedDescription)
//            }
//
//        }) { clues in
//            self.clues = clues
//        }
    }



    func getAllCluesInCategory(for id: Int,  cluesCount: Int) -> AnyPublisher<Clues, Error> {
        let url = URL(string: "http://www.jservice.io/api/clues?category=\(id)&offset=\(cluesCount - 4)")!
        return URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: Clues.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }


}
