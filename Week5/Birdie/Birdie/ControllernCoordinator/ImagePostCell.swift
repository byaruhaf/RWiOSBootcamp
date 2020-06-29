//
//  ImagePostCell.swift
//  Birdie
//
//  Created by Franklin Byaruhanga on 29/06/2020.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//

import UIKit

class ImagePostCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    @IBOutlet weak var textBodyLabel: UILabel!
    @IBOutlet weak var postImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
