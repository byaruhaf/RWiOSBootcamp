//
//  Date.swift
//  Birdui
//
//  Created by Maciej Szostak on 7/12/20.
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
