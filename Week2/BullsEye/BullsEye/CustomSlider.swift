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

    @IBInspectable var thumbImage: UIImage? {
        didSet {
            setThumbImage(thumbImage, for: .normal)
        }
    }

    @IBInspectable var thumbHighlightedImage: UIImage? {
        didSet {
            setThumbImage(thumbImage, for: .highlighted)
        }
    }

    //To set line height value from IB, here ten is default value
    @IBInspectable var trackLineHeight: CGFloat = 10

    //To set custom size of track so here override trackRect function of slider control
    override func trackRect(forBounds bound: CGRect) -> CGRect {
        //Here, set track frame
        return CGRect(origin: bound.origin, size: CGSize(width: bound.width, height: trackLineHeight))
    }

}
