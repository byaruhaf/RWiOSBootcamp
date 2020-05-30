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

  //bool to track currect mode.
  var isRGB: Bool = false
  var isHSB: Bool = false

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    setupSliders()
    setUpSelector()
  }

  // MARK: IBActions
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
// MARK: Setup functions

extension ViewController {
  fileprivate func setUpSelector() {
    colorModelSelector.backgroundColor = .systemBlue
    colorModelSelector.layer.borderColor = UIColor.white.cgColor
    colorModelSelector.selectedSegmentTintColor = UIColor.white
    colorModelSelector.layer.borderWidth = 1

    let titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    colorModelSelector.setTitleTextAttributes(titleTextAttributes, for: .normal)

    let titleTextAttributes1 = [NSAttributedString.Key.foregroundColor: UIColor.black]
    colorModelSelector.setTitleTextAttributes(titleTextAttributes1, for: .selected)
  }

  fileprivate func setupSliders() {
    switch colorModelSelector.selectedSegmentIndex {
    case 0:
      setupRGB()
    case 1:
      setupHSB()
    default:
      break
    }
    resetValues()
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
    let insets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)

    let redtrackleftImage = UIImage(named: "RedSliderTrackLeft")
    let bluetrackleftImage = UIImage(named: "BlueSliderTrackLeft")
    let greentrackleftImage = UIImage(named: "GreenSliderTrackLeft")
    let redtrackLeftImageresizable = redtrackleftImage?.resizableImage(withCapInsets: insets)
    let bluetrackLeftImageresizable = bluetrackleftImage?.resizableImage(withCapInsets: insets)
    let greentrackLeftImageresizable = greentrackleftImage?.resizableImage(withCapInsets: insets)
    sliderOne.setMinimumTrackImage(redtrackLeftImageresizable, for: .normal)
    sliderTwo.setMinimumTrackImage(greentrackLeftImageresizable, for: .normal)
    sliderThree.setMinimumTrackImage(bluetrackLeftImageresizable, for: .normal)

    let trackrightImage = UIImage(named: "SliderTrackRight")
    let trackRightImageresizable = trackrightImage?.resizableImage(withCapInsets: insets)
    sliderOne.setMaximumTrackImage(trackRightImageresizable, for: .normal)
    sliderTwo.setMaximumTrackImage(trackRightImageresizable, for: .normal)
    sliderThree.setMaximumTrackImage(trackRightImageresizable, for: .normal)
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

    let insets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)

    let trackleftImage = UIImage(named: "HSBSliderTrackLeft")
    let trackLeftImageresizable = trackleftImage?.resizableImage(withCapInsets: insets)
    sliderOne.setMinimumTrackImage(trackLeftImageresizable, for: .normal)
    sliderTwo.setMinimumTrackImage(trackLeftImageresizable, for: .normal)
    sliderThree.setMinimumTrackImage(trackLeftImageresizable, for: .normal)

    let trackrightImage = UIImage(named: "SliderTrackRight")
    let trackRightImageresizable = trackrightImage?.resizableImage(withCapInsets: insets)
    sliderOne.setMaximumTrackImage(trackRightImageresizable, for: .normal)
    sliderTwo.setMaximumTrackImage(trackRightImageresizable, for: .normal)
    sliderThree.setMaximumTrackImage(trackRightImageresizable, for: .normal)

  }

  fileprivate func resetValues() {
    //Reset all to avoid confusion
    self.sliderOneValue.text = "0"
    self.sliderTwoValue.text = "0"
    self.sliderThreeValue.text = "0"
    sliderOne.value = 0.0
    sliderTwo.value = 0.0
    sliderThree.value = 0.0
    colorView.backgroundColor = .bitterSweet
    colorname.isHidden = true
    sliderOneLable.textColor = UIColor.bitterSweet.inverseColor()
    sliderTwoLable.textColor = UIColor.bitterSweet.inverseColor()
    sliderThreeLable.textColor = UIColor.bitterSweet.inverseColor()
    sliderOneValue.textColor = UIColor.bitterSweet.inverseColor()
    sliderTwoValue.textColor = UIColor.bitterSweet.inverseColor()
    sliderThreeValue.textColor = UIColor.bitterSweet.inverseColor()
  }

  fileprivate func setupColors(colorname: String?) {
    //set color name and backgroud view
    guard let colorname = colorname else { return }
    self.colorname.text = colorname.uppercased()
    self.colorname.isHidden = false
    colorView.backgroundColor = calculateColor()
    //set lables to inverse Color so they are visible after backgroundColor change.
    self.colorname.textColor = calculateColor().inverseColor()
    sliderOneLable.textColor = calculateColor().inverseColor()
    sliderTwoLable.textColor = calculateColor().inverseColor()
    sliderThreeLable.textColor = calculateColor().inverseColor()
    sliderOneValue.textColor = calculateColor().inverseColor()
    sliderTwoValue.textColor = calculateColor().inverseColor()
    sliderThreeValue.textColor = calculateColor().inverseColor()
  }
}

// MARK: Color Calculator funciton

extension ViewController {
  fileprivate func calculateColor() -> UIColor {
    if isRGB {
      // Create Color using RGB
      return UIColor(
        rgbColorCodeRed: sliderOne.value, green: sliderTwo.value, blue: sliderThree.value)
    } else {
      // Create Color using HSB
      return UIColor(
        hsbColorCodeHue: sliderOne.value, saturation: sliderTwo.value, brightness: sliderThree.value
      )
    }
  }
}

// MARK: Alert User funcitons

extension ViewController {
  fileprivate func showColorNameAlert() {
    let alertCtr = UIAlertController(
      title: "Color Name", message: "Please enter your Color Name", preferredStyle: .alert)
    alertCtr.addTextField { (textField: UITextField!) -> Void in
      textField.placeholder = "e.g JUJUBlue"
    }
    let saveAction = UIAlertAction(
      title: "Set Color", style: .default,
      handler: { [weak self, weak alertCtr] alert -> Void in
        if let textField = alertCtr?.textFields?[0] {
          self?.setupColors(colorname: textField.text)
        }
      })
    let cancelAction = UIAlertAction(
      title: "Cancel", style: .destructive,
      handler: {
        (action: UIAlertAction!) -> Void in
        self.setupSliders()
      })

    alertCtr.addAction(saveAction)
    alertCtr.addAction(cancelAction)
    alertCtr.preferredAction = saveAction
    self.present(alertCtr, animated: true, completion: nil)
  }
}

// MARK: Segue to WikiViewController
extension ViewController {
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "wikipedia" {
      let controller = segue.destination as! WikiViewController
      // Determine which wikipedia page to show depending on currently selected color mode
      if isRGB {
        controller.wikiURL = URL(string: "https://en.wikipedia.org/wiki/RGB_color_model")
      } else {
        controller.wikiURL = URL(string: "https://en.wikipedia.org/wiki/HSL_and_HSV")!
      }
    }
  }
}
