//
//  CustomView.swift
//  BullsEye
//
//  Created by Franklin Byaruhanga on 07/06/2020.
//  Copyright © 2020 Ray Wenderlich. All rights reserved.
//

import UIKit


@IBDesignable
class CustomView: UIView {
    @IBInspectable var cornerRadiusValue: CGFloat = 10.0 {
        didSet {
            setUpView()
        }
    }
  @IBInspectable var borderWidth: CGFloat = 1.0 {
    didSet {
      setUpView()
    }
  }
  @IBInspectable var shadowRadius: CGFloat = 4 {
    didSet {
      setUpView()
    }
  }
  @IBInspectable var shadowOpacity: Float = 0.8 {
    didSet {
      setUpView()
    }
  }
  @IBInspectable var shadowOffset: CGSize = CGSize(width: 0, height: 2) {
    didSet {
      setUpView()
    }
  }
  @IBInspectable var shadowColor: CGColor = UIColor.black.withAlphaComponent(0.7).cgColor{
    didSet {
      setUpView()
    }
  }
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpView()
    }
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setUpView()
    }
    func setUpView() {
        self.layer.cornerRadius = self.cornerRadiusValue
      self.layer.borderWidth = self.borderWidth
      self.layer.shadowRadius = self.shadowRadius
      self.layer.shadowOpacity = self.shadowOpacity
      self.layer.cornerRadius = self.cornerRadiusValue
      self.layer.shadowOffset = self.shadowOffset
      self.layer.shadowColor = self.shadowColor
    }
}
