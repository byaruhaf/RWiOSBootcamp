//
//  NetworkingHandler.swift
//  jQuiz
//
//  Created by Jay Strawn on 7/17/20.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//

import Foundation
import Combine


class Networking {
    static let sharedInstance = Networking()
    var imageDictionary = [String:Data]()

    func loadData() -> AnyPublisher<Clues, Error> {
        let url = Endpoint.randomCategory().url!
        return fetch(url: url)
            .decode(type: Clues.self, decoder: JSONDecoder())
            .tryMap { category in
                guard let categoryID = category.first?.categoryID else { throw APIError.parserError(reason: "invalid categoryID")}
                guard let cluesCount = category.first?.category?.cluesCount else { throw APIError.parserError(reason: "invalid cluesCount")}
//                print("\(categoryID)")
                return (categoryID,cluesCount)
        }
        .flatMap { (categoryID,cluesCount) in
            return self.getAllCluesInCategory(for: categoryID, cluesCount: cluesCount)
        }
        .eraseToAnyPublisher()
    }


    func getAllCluesInCategory(for id: Int,  cluesCount: Int) -> AnyPublisher<Clues, Error> {
        let url = Endpoint.CategorylookUp(id: id, cluesCount: cluesCount).url!
        //let url = URL(string: "http://www.jservice.io/api/clues?category=31&offset=221")!
//        print(url)
        return fetch(url: url)
            .decode(type: Clues.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }


    func fetch(url: URL) -> AnyPublisher<Data, APIError> {
        let request = URLRequest(url: url)
        return URLSession.DataTaskPublisher(request: request, session: .shared)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse else {
                    throw APIError.unknown
                }
                if (httpResponse.statusCode == 401) {
                    throw APIError.apiError(reason: "Unauthorized");
                }
                if (httpResponse.statusCode == 403) {
                    throw APIError.apiError(reason: "Resource forbidden");
                }
                if (httpResponse.statusCode == 404) {
                    throw APIError.apiError(reason: "Resource not found");
                }
                if (405..<500 ~= httpResponse.statusCode) {
                    throw APIError.apiError(reason: "client error");
                }
                if (500..<600 ~= httpResponse.statusCode) {
                    throw APIError.apiError(reason: "server error");
                }
                return data
        }
        .mapError { error in
            // if it's our kind of error already, we can return it directly
            if let error = error as? APIError {
                return error
            }
            // if it is a URLError, we can convert it into our more general error kind
            if let urlerror = error as? URLError {
                return APIError.networkError(from: urlerror)
            }
            // if all else fails, return the unknown error condition
            return APIError.unknown
        }
        .eraseToAnyPublisher()
    }
}


enum APIError: Error, LocalizedError {
    case unknown, apiError(reason: String), parserError(reason: String), networkError(from: URLError)

    var errorDescription: String? {
        switch self {
            case .unknown:
                return "Unknown error"
            case .apiError(let reason), .parserError(let reason):
                return reason
            case .networkError(let from):
                return from.localizedDescription
        }
    }
}


