//
//  JServiceError.swift
//  jQuiz
//
//  Created by Franklin Byaruhanga on 22/07/2020.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//


import Foundation

enum JServiceError:Error {
    case requestFailed
    case responseUnsuccessful
    case invalidData
    case jsonConversionFailure
    case jsonParsingFailure(message:String)
}

