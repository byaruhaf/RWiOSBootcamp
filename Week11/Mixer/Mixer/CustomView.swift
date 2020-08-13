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
        self.clipsToBounds = true
        self.layer.borderWidth = 5
        self.layer.borderColor = UIColor(hue: 0.15, saturation: 0.88, brightness: 1.00, alpha: 1.00).cgColor
    }
}
