//
//  ViewController.swift
//  ColorSlider
//
//  Created by Franklin Byaruhanga on 29/05/2020.
//  Copyright © 2020 Franklin Byaruhanga. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    // MARK: IBOutlet
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
    @IBOutlet weak var colorView: UIView!

    //color for colorView
    var color: UIColor = .white
    var isRGB:Bool = false
    var isHSB:Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupSliders() 
    }

    private func setupSliders() {

        switch colorModelSelector.selectedSegmentIndex {
        case 0:
            isRGB = true
            isHSB = false
            sliderOneLable.text = "Red"
            sliderTwoLable.text = "Green"
            sliderThreeLable.text = "Blue"
            sliderOne.maximumValue = 255
            sliderTwo.maximumValue = 255
            sliderThree.maximumValue = 255

        case 1:
            isRGB = false
            isHSB = true
            sliderOneLable.text = "Hue"
            sliderTwoLable.text = "Saturation"
            sliderThreeLable.text = "Brightness"
            sliderOne.maximumValue = 360
            sliderTwo.maximumValue = 100
            sliderThree.maximumValue = 100
        default:
            break;
        }
        self.sliderOneValue.text = "0"
        self.sliderTwoValue.text = "0"
        self.sliderThreeValue.text = "0"
        // Configure Sliders
        sliderOne.value = 0.0
        sliderTwo.value = 0.0
        sliderThree.value = 0.0
    }


// moving of Slider Updates Values displayed
    @IBAction func sliderMoved(_ sender: UISlider) {
        self.sliderOneValue.text = "\(Int(sliderOne.value))"
        self.sliderTwoValue.text = "\(Int(sliderTwo.value))"
        self.sliderThreeValue.text = "\(Int(sliderThree.value))"
    }


    @IBAction func updateColor(_ sender: Any) {
        if isRGB {
            // Create Color using RGB
            let color = UIColor(rgbColorCodeRed: sliderOne.value, green: sliderTwo.value, blue: sliderThree.value)


            // Configure Color View
            colorView.backgroundColor = color
        }
        if isHSB {
            // Create Color using HSB
            let color = UIColor(hsbColorCodeHue: sliderOne.value, saturation: sliderTwo.value, brightness: sliderThree.value)
            // Configure Color View
            colorView.backgroundColor = color
        }
    }
    @IBAction func resetSelection(_ sender: Any) {
        setupSliders()
    }
    @IBAction func modeChanged(_ sender: Any) {
        setupSliders()
    }


}

