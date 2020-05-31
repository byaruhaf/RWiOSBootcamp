//
//  UserDefaults.swift
//  ColorSlider
//
//  Created by Franklin Byaruhanga on 31/05/2020.
//  Copyright © 2020 Franklin Byaruhanga. All rights reserved.
//

import UIKit.UIColor

extension UserDefaults {
    func color(forKey: String) -> UIColor? {
        var colorSaved: UIColor?
        if let colorData = data(forKey: forKey) {
            do {
                if let color = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(colorData) as? UIColor {
                    colorSaved = color
                }
            } catch {
                print("Error UserDefaults")
            }
        }
        return colorSaved
    }

    func set(color: UIColor?, forKey key: String) {
        var colorData: NSData?
        if let color = color {
            do {
                let data = try NSKeyedArchiver.archivedData(withRootObject: color, requiringSecureCoding: false) as NSData?
                colorData = data
            } catch {
                print("Error UserDefaults")
            }
        }
        set(colorData, forKey: key)
    }
}
