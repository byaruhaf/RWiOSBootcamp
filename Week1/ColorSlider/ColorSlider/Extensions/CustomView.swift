//
//  CustomView.swift
//  ColorSlider
//
//  Created by Franklin Byaruhanga on 31/05/2020.
//  Copyright © 2020 Franklin Byaruhanga. All rights reserved.
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
    }
}
