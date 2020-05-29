//
//  ViewController.swift
//  ColorSlider
//
//  Created by Franklin Byaruhanga on 29/05/2020.
//  Copyright © 2020 Franklin Byaruhanga. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var colorModelSelector: UISegmentedControl!
    @IBOutlet weak var colorname: UILabel!
    // Red or Hue IBOutlet's
    @IBOutlet weak var sliderOne: UISlider!
    @IBOutlet weak var sliderOneLable: UILabel!
    @IBOutlet weak var sliderOneValue: UILabel!
    // Green or Saturation IBOutlet's
    @IBOutlet weak var sliderTwo: UISlider!
    @IBOutlet weak var sliderTwoLable: UILabel!
    @IBOutlet weak var sliderTwoValue: UILabel!
    // Blue or Brightness IBOutlet's
    @IBOutlet weak var sliderThree: UISlider!
    @IBOutlet weak var sliderThreeLable: UILabel!
    @IBOutlet weak var sliderThreeValue: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

