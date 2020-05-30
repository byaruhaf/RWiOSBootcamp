//
//  UIColor.swift
//  ColorSlider
//
//  Created by Franklin Byaruhanga on 29/05/2020.
//  Copyright © 2020 Franklin Byaruhanga. All rights reserved.
//
import UIKit.UIColor

// initial background color of the app
extension UIColor {
    static let bitterSweet = UIColor(hsbColorCodeHue:154, saturation:59, brightness:25)
}

// Addpating UIColor initializer to make it easier at the call site
extension UIColor {
    convenience init(rgbColorCodeRed red: Float, green: Float, blue: Float) {
        let redPart: CGFloat = CGFloat(red) / 255
        let greenPart: CGFloat = CGFloat(green) / 255
        let bluePart: CGFloat = CGFloat(blue) / 255
        let alpha: CGFloat = 1.0
        self.init(red: redPart, green: greenPart, blue: bluePart, alpha: alpha)
    }
    convenience init(hsbColorCodeHue hue: Float, saturation: Float, brightness: Float) {
        let hue: CGFloat = CGFloat(hue) / 360
        let saturation: CGFloat = CGFloat(saturation) / 100
        let brightness: CGFloat = CGFloat(brightness) / 100
        let alpha: CGFloat = 1.0
        self.init(hue: hue, saturation: saturation, brightness: brightness, alpha: alpha)
    }

}

// Addpating UIColor to provide an the reverse of the color selected by the user
// so the text color in the lables can addapt to user color's
extension UIColor {
    func inverseColor() -> UIColor {
        var alpha: CGFloat = 1.0

        var white: CGFloat = 0.0
        if self.getWhite(&white, alpha: &alpha) {
            return UIColor(white: 1.0 - white, alpha: alpha)
        }

        var hue: CGFloat = 0.0, saturation: CGFloat = 0.0, brightness: CGFloat = 0.0
        if self.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha) {
            return UIColor(hue: 1.0 - hue, saturation: 1.0 - saturation, brightness: 1.0 - brightness, alpha: alpha)
        }

        var red: CGFloat = 0.0, green: CGFloat = 0.0, blue: CGFloat = 0.0
        if self.getRed(&red, green: &green, blue: &blue, alpha: &alpha) {
            return UIColor(red: 1.0 - red, green: 1.0 - green, blue: 1.0 - blue, alpha: alpha)
        }

        return self
    }

}
