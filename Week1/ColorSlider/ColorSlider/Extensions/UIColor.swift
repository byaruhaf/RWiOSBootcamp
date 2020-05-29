//
//  UIColor.swift
//  ColorSlider
//
//  Created by Franklin Byaruhanga on 29/05/2020.
//  Copyright © 2020 Franklin Byaruhanga. All rights reserved.
//
import UIKit.UIColor

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
