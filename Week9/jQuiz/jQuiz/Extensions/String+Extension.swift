//
//  String+Extension.swift
//  jQuiz
//
//  Created by Franklin Byaruhanga on 23/07/2020.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//

import Foundation
import UIKit

extension String {
    var firstCharacterUpperCase: String {
        let lowerCasedString = self.lowercased()
        return lowerCasedString.replacingCharacters(in: lowerCasedString.startIndex...lowerCasedString.startIndex, with: String(lowerCasedString[lowerCasedString.startIndex]).uppercased())
    }
}

extension String{
    var htmlStripped : String{
        return self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    }
}


extension String{
    var nonAsciStripped : String{
        return self.replacingOccurrences(of: "[^\\x00-\\x7F]", with: "", options: .regularExpression, range: nil)
    }
}
