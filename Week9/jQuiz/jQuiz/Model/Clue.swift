//
//  QuestionCodable.swift
//  jQuiz
//
//  Created by Jay Strawn on 7/17/20.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//

import Foundation

// MARK: - Clue
struct Clue: Codable {
    let id: Int?
    let answer, question: String?
    let points: Int?
    let categoryID: Int?
    let category: Category?

    enum CodingKeys: String, CodingKey {
        case id, answer, question
        case points = "value"
        case categoryID = "category_id"
        case category
    }
}


// MARK: - Category
struct Category: Codable {
    let id: Int?
    let title: String?
    let cluesCount: Int?

    enum CodingKeys: String, CodingKey {
        case id, title
        case cluesCount = "clues_count"
    }
}



typealias Clues = [Clue]
