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

}
