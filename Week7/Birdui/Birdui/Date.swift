//
//  Date.swift
//  Birdui
//
//  Created by Franklin Byaruhanga on 08/07/2020.
//  Copyright © 2020 Razeware. All rights reserved.
//

import UIKit

extension Date {
    func toString(withFormat format: String = "d MMM, HH:mm") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        let str = dateFormatter.string(from: self)
        return str
    }
}
