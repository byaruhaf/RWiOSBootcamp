//
//  ColorViewController.swift
//  ColorSlider
//
//  Created by Franklin Byaruhanga on 29/05/2020.
//  Copyright © 2020 Franklin Byaruhanga. All rights reserved.
//

import UIKit

class ColorViewController: UIViewController {
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
  @IBOutlet weak var colorView: CustomView!
  @IBOutlet weak var hexLabel: UILabel!

  //bool to track currect mode.
  var currentMode: ColorModeState = .isRGB

  //curent Hex value
  var currentHex: String = ""

  //UserDefaults constant
  let defaults = UserDefaults.standard

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    setupSliders()
    setUpSelector()
    getUserSavedColors()
  }

  // MARK: IBActions
  // moving of Slider Updates Values displayed
  @IBAction func sliderMoved(_ sender: UISlider) {
    self.sliderOneValue.text = "\(Int(sliderOne.value))"
    self.sliderTwoValue.text = "\(Int(sliderTwo.value))"
    self.sliderThreeValue.text = "\(Int(sliderThree.value))"
    colorView.backgroundColor = calculateColor()
     self.colorname.textColor = inverseColor()
    // set Hex Value on Lable.
//    if let colorHex = calculateColor().toHex(alpha: false) {
    let colorHex = calculateColor().toHexString()
    colorname.text = "HEX: \(colorHex)".uppercased()
    currentHex = "HEX: \(colorHex)".uppercased()

    UIView.transition(
      with: hexLabel, duration: 0.4,
      options: .transitionCrossDissolve,
      animations: {
        self.hexLabel.isHidden = true
      })
  }
  @IBAction func setColorTapped(_ sender: Any) {
    showColorNameAlert()
  }
  @IBAction func resetSelection(_ sender: Any) {
    setupSliders()
    clearUserSavedColors()
  }
  @IBAction func modeChanged(_ sender: Any) {
    setupSliders()
  }
}
// MARK: Setup functions

extension ColorViewController {
  //set up  text & ccolors for colorModelSelector view
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

  //setup text & colors depending on the color mode selected.
  fileprivate func setupSliders() {
    switch colorModelSelector.selectedSegmentIndex {
    case 0:
      currentMode = .isRGB
      setupRGB()
    case 1:
      currentMode = .isP3RGB
      setupRGB()
    case 2:
      currentMode = .isHSB
      setupHSB()
    default:
      break
    }
    resetValues()
  }

  //slider configuration performed when RGB is selected.
  fileprivate func setupRGB() {
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

  //slider configuraion performed when HSB is selected.
  fileprivate func setupHSB() {
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

  //configuraion performed during app startup & when reset button is tapped
  fileprivate func resetValues() {
    //Reset all to avoid confusion
    self.sliderOneValue.text = "0"
    self.sliderTwoValue.text = "0"
    self.sliderThreeValue.text = "0"
    // smoth the reset of the slider's with animaiton
    UIView.animate(
      withDuration: 0.4,
      animations: {
        self.sliderOne.setValue(0, animated: true)
        self.sliderTwo.setValue(0, animated: true)
        self.sliderThree.setValue(0, animated: true)
      })
    self.colorname.text = "HEX: #"
    // smoth hiding hexlable with animaiton
    UIView.transition(
      with: hexLabel, duration: 0.4,
      options: .transitionCrossDissolve,
      animations: {
        self.hexLabel.isHidden = true
      })
    // smoth the reset background color with animaiton
    UIView.animate(withDuration: 2) {
      self.view.backgroundColor = .bitterSweet
    }

    colorView.backgroundColor = self.view.backgroundColor
    sliderOneLable.textColor = UIColor.bitterSweet.inverseHSBColor()
    sliderTwoLable.textColor = UIColor.bitterSweet.inverseHSBColor()
    sliderThreeLable.textColor = UIColor.bitterSweet.inverseHSBColor()
    sliderOneValue.textColor = UIColor.bitterSweet.inverseHSBColor()
    sliderTwoValue.textColor = UIColor.bitterSweet.inverseHSBColor()
    sliderThreeValue.textColor = UIColor.bitterSweet.inverseHSBColor()
    hexLabel.textColor = UIColor.bitterSweet.inverseHSBColor()
  }

  //configuraion performed when user tapps enter button after setting the name.
  fileprivate func setupColors(usercolorname: String?) {
    //set color name and backgroud view
    guard let usercolorname = usercolorname else { return }
    self.colorname.text = usercolorname.uppercased()
    self.hexLabel.text = currentHex
    self.hexLabel.isHidden = true
    self.hexLabel.isHidden = false

    UIView.animate(withDuration: 2) {
      self.view.backgroundColor = self.calculateColor()
      self.colorView.backgroundColor = self.calculateColor()
    }

    //set lables to inverse Color so they are visible after backgroundColor change.
    //check if RGB mode is active then selecte correct inverse function.
    self.colorname.textColor = inverseColor()
    sliderOneLable.textColor = inverseColor()
    sliderTwoLable.textColor = inverseColor()
    sliderThreeLable.textColor = inverseColor()
    sliderOneValue.textColor = inverseColor()
    sliderTwoValue.textColor = inverseColor()
    sliderThreeValue.textColor = inverseColor()
    hexLabel.textColor = inverseColor()
    saveUserColors()
  }

  fileprivate func inverseColor() -> UIColor {
    switch currentMode {
    case .isRGB:
      return calculateColor().inverseRGBColor()
    case .isP3RGB:
      return calculateColor().inverseRGBColor()
    case .isHSB:
      return calculateColor().inverseHSBColor()
    }
  }

}

// MARK: UserDefaults funcitons to save User Colors
extension ColorViewController {

  fileprivate func getUserSavedColors() {
    guard let userColorName = defaults.string(forKey: "colorname") else { return }
    self.colorname.isHidden = false
    self.colorname.text = userColorName
    guard let backgroundColor = defaults.color(forKey: "appColor") else { return }
    self.view.backgroundColor = backgroundColor
    self.colorView.backgroundColor = backgroundColor

    self.sliderOne.value = defaults.float(forKey: "sliderOne")
    self.sliderTwo.value = defaults.float(forKey: "sliderTwo")
    self.sliderThree.value = defaults.float(forKey: "sliderThree")
  }

  fileprivate func saveUserColors() {
    // save current background Color
    defaults.set(color: self.view.backgroundColor, forKey: "appColor")
    // current color name
    defaults.set(colorname.text, forKey: "colorname")
    // current value of slider 1
    defaults.set(sliderOne.value, forKey: "sliderOne")
    // current value of slider 1
    defaults.set(sliderTwo.value, forKey: "sliderTwo")
    // current value of slider 1
    defaults.set(sliderThree.value, forKey: "sliderThree")
  }

  fileprivate func clearUserSavedColors() {
    // remove saved background Color
    defaults.removeObject(forKey: "appColor")
    // remove saved color name
    defaults.removeObject(forKey: "colorname")
    // remove saved  value for slider 1
    defaults.removeObject(forKey: "sliderOne")
    // remove saved  value for slider 1
    defaults.removeObject(forKey: "sliderTwo")
    // remove saved  value for slider 1
    defaults.removeObject(forKey: "sliderThree")
  }

}

// MARK: Color Calculator funciton
extension ColorViewController {
  fileprivate func calculateColor() -> UIColor {
    switch currentMode {
    case .isRGB:
      return UIColor(
        rgbColorCodeRed: sliderOne.value, green: sliderTwo.value, blue: sliderThree.value)
    case .isP3RGB:
      return UIColor(
        p3rgbColorCodeRed: sliderOne.value, green: sliderTwo.value, blue: sliderThree.value)
    case .isHSB:
      return UIColor(
        hsbColorCodeHue: sliderOne.value, saturation: sliderTwo.value, brightness: sliderThree.value
      )
    }
  }
}

// MARK: Alert User funcitons
extension ColorViewController {
  fileprivate func showColorNameAlert() {
    let alertCtr = UIAlertController(
      title: "Color Name", message: "Please enter your Color Name", preferredStyle: .alert)
    alertCtr.addTextField { (textField: UITextField!) -> Void in
      textField.placeholder = "e.g JUJUBlue"
    }
    let saveAction = UIAlertAction(
      title: "Set Color", style: .default,
      handler: { [weak self, weak alertCtr] _ -> Void in
        if let textField = alertCtr?.textFields?[0] {
          self?.setupColors(usercolorname: textField.text)
        }
      })
    let cancelAction = UIAlertAction(
      title: "Cancel", style: .destructive,
      handler: { (_: UIAlertAction!) -> Void in
        self.setupSliders()
      })

    alertCtr.addAction(saveAction)
    alertCtr.addAction(cancelAction)
    alertCtr.preferredAction = saveAction
    self.present(alertCtr, animated: true, completion: nil)
  }
}

// MARK: Segue to WikiViewController
extension ColorViewController {
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "wikipedia" {
    guard let controller = segue.destination as? WikiViewController else { return }
      // Determine which wikipedia page to show depending on currently selected color mode
      switch currentMode {
      case .isRGB:
        controller.wikiURL = URL(string: "https://en.wikipedia.org/wiki/RGB_color_model")
      case .isP3RGB:
        controller.wikiURL = URL(string: "https://en.wikipedia.org/wiki/DCI-P3")!
      case .isHSB:
        controller.wikiURL = URL(string: "https://en.wikipedia.org/wiki/HSL_and_HSV")!
      }

    }
  }
}
