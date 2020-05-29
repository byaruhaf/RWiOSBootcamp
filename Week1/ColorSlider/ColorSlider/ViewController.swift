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
    var isRGB: Bool = false
    var isHSB: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    setupSliders()
    }

    // MARK: Color mode setup functions
    private func setupSliders() {
        switch colorModelSelector.selectedSegmentIndex {
        case 0:
            setupRGB()
        case 1:
            setupHSB()
        default:
            break
        }
        //Reset all to avoid confusion
        self.sliderOneValue.text = "0"
        self.sliderTwoValue.text = "0"
        self.sliderThreeValue.text = "0"
        sliderOne.value = 0.0
        sliderTwo.value = 0.0
        sliderThree.value = 0.0
        colorView.backgroundColor = .white
    }

    fileprivate func setupRGB() {
        isRGB = true
        isHSB = false
        sliderOneLable.text = "Red"
        sliderTwoLable.text = "Green"
        sliderThreeLable.text = "Blue"
        sliderOne.maximumValue = 255
        sliderTwo.maximumValue = 255
        sliderThree.maximumValue = 255
    }

    fileprivate func setupHSB() {
        isRGB = false
        isHSB = true
        sliderOneLable.text = "Hue"
        sliderTwoLable.text = "Saturation"
        sliderThreeLable.text = "Brightness"
        sliderOne.maximumValue = 360
        sliderTwo.maximumValue = 100
        sliderThree.maximumValue = 100
    }

    fileprivate func calculateColor() -> UIColor {
        if isRGB {
            // Create Color using RGB
            return UIColor(rgbColorCodeRed: sliderOne.value, green: sliderTwo.value, blue: sliderThree.value)
        } else{
            // Create Color using HSB
           return UIColor(hsbColorCodeHue: sliderOne.value, saturation: sliderTwo.value, brightness: sliderThree.value)
        }
    }

    fileprivate func showColorNameAlert(){
        let alertCtr = UIAlertController(title: "Enter Cool Color Name", message: "", preferredStyle: .alert)
        alertCtr.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Color Name"
        }
        let saveAction = UIAlertAction(title: "Set Color", style: .default, handler: { [weak self, weak alertCtr] alert -> Void in
            if let textField = alertCtr?.textFields?[0] {
                self?.colorname.text = textField.text
                self?.colorView.backgroundColor = self?.calculateColor()
            }
        })
        // Change alert backgroundColor as hint for user.
        alertCtr.view.subviews.first?.subviews.first?.subviews.first?.backgroundColor = self.calculateColor()
        // Accessing buttons tintcolor :
        alertCtr.view.tintColor = UIColor.white
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: {
            (action : UIAlertAction!) -> Void in
            self.setupSliders()
        })

        alertCtr.addAction(saveAction)
        alertCtr.addAction(cancelAction)
        alertCtr.preferredAction = saveAction
        self.present(alertCtr, animated: true, completion: nil)
    }

    // moving of Slider Updates Values displayed
    @IBAction func sliderMoved(_ sender: UISlider) {
        self.sliderOneValue.text = "\(Int(sliderOne.value))"
        self.sliderTwoValue.text = "\(Int(sliderTwo.value))"
        self.sliderThreeValue.text = "\(Int(sliderThree.value))"
    }

    @IBAction func setColorTapped(_ sender: Any) {
        showColorNameAlert()
    }

    @IBAction func resetSelection(_ sender: Any) {
        setupSliders()
    }
    @IBAction func modeChanged(_ sender: Any) {
        setupSliders()
    }

}
