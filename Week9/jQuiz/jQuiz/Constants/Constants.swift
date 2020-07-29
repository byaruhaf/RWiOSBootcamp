//
//  Constants.swift
//  jQuiz
//
//  Created by Franklin Byaruhanga on 25/07/2020.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//

import Foundation
import UIKit.UIColor

struct K {
    struct Keys {
        static let soundKey = "com.AppBantu.Sound.enabled"
        static let iamgeKey = "logoImage"
    }

    struct URL {
        static let imageURL = "https://cdn.dribbble.com/users/1405795/screenshots/4801691/1.jpg"
        static let apiURL = "www.jservice.io"
    }

    struct Colours {
        static let c1 = UIColor(hue:0.704, saturation:0.884, brightness:0.719, alpha:1.000)
        static let c2 = UIColor(hue:0.762, saturation:0.667, brightness:0.800, alpha:1.000)
    }


}

struct CellType {
    static let answerCell = "AnswerCell"
}
