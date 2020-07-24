//
//  AnswerTableViewCell.swift
//  jQuiz
//
//  Created by Franklin Byaruhanga on 23/07/2020.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//

import UIKit

class AnswerTableViewCell: UITableViewCell {
    @IBOutlet weak var qLable: UILabel!
    @IBOutlet weak var backView: UIView!
    
    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
    }

    override func awakeFromNib() {
        // add shadow on cell
        backgroundColor = .clear // very important
        layer.masksToBounds = false
        layer.shadowOpacity = 0.23
        layer.shadowRadius = 4
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowColor = UIColor.black.cgColor

        // add corner radius on `contentView`
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 20
    }
}
