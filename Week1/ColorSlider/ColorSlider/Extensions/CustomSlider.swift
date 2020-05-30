//
//  CustomSlider.swift
//  ColorSlider
//
//  Created by Franklin Byaruhanga on 30/05/2020.
//  Copyright © 2020 Franklin Byaruhanga. All rights reserved.
//

import UIKit

@IBDesignable
class CustomSlider: UISlider {

    @IBInspectable var ThumbImage: UIImage? {
        didSet {
            setThumbImage(ThumbImage, for: .normal)
        }
    }

    @IBInspectable var ThumbHighlightedImage: UIImage? {
        didSet {
            setThumbImage(ThumbImage, for: .highlighted)
        }
    }

}
