//
//  CustomButton.swift
//  ColorSlider
//
//  Created by Franklin Byaruhanga on 29/05/2020.
//  Copyright © 2020 Franklin Byaruhanga. All rights reserved.
//

import UIKit.UIButton

class CustomButton: UIButton {
  override func awakeFromNib() {
    super.awakeFromNib()
    setUpView()
  }
  override func prepareForInterfaceBuilder() {
    super.prepareForInterfaceBuilder()
    setUpView()
  }
  func setUpView() {
    self.layer.cornerRadius = self.frame.width/2
    self.layer.masksToBounds = true
  }
}
