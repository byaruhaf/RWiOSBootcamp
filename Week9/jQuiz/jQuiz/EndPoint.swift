//
//  EndPoint.swift
//  jQuiz
//
//  Created by Franklin Byaruhanga on 25/07/2020.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//
import Foundation

struct Endpoint {
    let path: String
    let queryItems: [URLQueryItem]
}

//randomCategory Endpoint
extension Endpoint {
    static func randomCategory() -> Endpoint {
        return Endpoint(path: "/api/random", queryItems: [])
    }
}

//CategorylookUp Endpoint
extension Endpoint {
    static func CategorylookUp(id: Int, cluesCount: Int) -> Endpoint {
        var result = [URLQueryItem]()
        let categoryID = URLQueryItem(name: "category", value: id.description)
        result.append(categoryID)

        let apiOffset = URLQueryItem(name: "offset", value: (cluesCount <= 4 ? 0 : cluesCount - 4).description)
        result.append(apiOffset)

        return Endpoint(path: "/api/clues", queryItems: result)
    }
}

extension Endpoint {
    // We still have to keep 'url' as an optional, since we're
    // dealing with dynamic components that could be invalid.
    var url: URL? {
        var components = URLComponents()
        components.scheme = "http"
        components.host = K.URL.apiURL
        components.path = path
        components.queryItems = queryItems
        guard let url = components.url else { preconditionFailure("Invalid URL components: \(components)")}
        return url
    }
}
