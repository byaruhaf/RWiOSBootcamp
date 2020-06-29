//
//  View.swift
//  Birdie
//
//  Created by Franklin Byaruhanga on 29/06/2020.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//

import UIKit

extension UIView {
    convenience init(backgroundColor: UIColor) {
        self.init()
        self.backgroundColor = backgroundColor
    }

    // Separator for tableview Cells
    func addSeparator() {
        let separatorHeight: CGFloat = 2
        let frame = CGRect(x: 0, y: bounds.height - separatorHeight, width: bounds.width, height: separatorHeight)
        let separator = UIView(frame: frame)
        separator.backgroundColor = .gray
        separator.autoresizingMask = [.flexibleTopMargin, .flexibleWidth]

        addSubview(separator)
    }
}
