//
//  GradientBack.swift
//  Birdui
//
//  Created by Franklin Byaruhanga on 08/07/2020.
//  Copyright © 2020 Razeware. All rights reserved.
//

import SwiftUI

struct GradientBack {
    static var linear:LinearGradient { LinearGradient(gradient: Gradient(colors:
        [Color(hue:0.092, saturation:0.632, brightness:0.935), Color(hue:0.013,
        saturation:0.843, brightness:0.985)]), startPoint: .leading, endPoint: .trailing)
    }
}



