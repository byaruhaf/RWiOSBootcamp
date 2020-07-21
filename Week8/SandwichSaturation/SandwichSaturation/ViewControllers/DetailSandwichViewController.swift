//
//  DetailSandwichViewController.swift
//  SandwichSaturation
//
//  Created by Franklin Byaruhanga on 21/07/2020.
//  Copyright © 2020 Jeff Rames. All rights reserved.
//

import UIKit

class DetailSandwichViewController: UIViewController {

    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var sauceAmountSegmentedControl: UISegmentedControl!


    var sandwich:SandwichModel! = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        nameField.text = sandwich.name
        imageView.image = UIImage.init(imageLiteralResourceName: sandwich.imageName!)
        sauceAmountSegmentedControl.selectedSegmentIndex = sandwich.tosauceAmount?.sauceAmount.rawValue == "None" ? 0 : 1
    }
    

}
