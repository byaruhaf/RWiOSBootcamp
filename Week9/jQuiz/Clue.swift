//
//  QuestionCodable.swift
//  jQuiz
//
//  Created by Jay Strawn on 7/17/20.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//

import Foundation

// MARK: - ClueElement
struct Clue: Codable {
    let id: Int?
    let answer, question: String?
    let value: Int?
    let airdate: Airdate?
    let createdAt, updatedAt: String?
    let categoryID: Int?
    let gameID, invalidCount: Int?
    let category: Category?

    enum CodingKeys: String, CodingKey {
        case id, answer, question, value, airdate
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case categoryID = "category_id"
        case gameID = "game_id"
        case invalidCount = "invalid_count"
        case category
    }
}

enum Airdate: String, Codable {
    case the20141006T120000000Z = "2014-10-06T12:00:00.000Z"
}

// MARK: - Category
struct Category: Codable {
    let id: Int?
    let title: Title?
    let createdAt, updatedAt: AtedAt?
    let cluesCount: Int?

    enum CodingKeys: String, CodingKey {
        case id, title
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case cluesCount = "clues_count"
    }
}

enum AtedAt: String, Codable {
    case the20150118T181812642Z = "2015-01-18T18:18:12.642Z"
}

enum Title: String, Codable {
    case drawingTheLine = "drawing the \"line\""
}

typealias Clues = [Clue]
