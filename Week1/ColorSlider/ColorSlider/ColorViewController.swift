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
  var isRGB: Bool = false
    var isP3RGB: Bool = false
  var isHSB: Bool = false


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
    // set Hex Value on Lable.
    if let colorHex = calculateColor().toHex {
         hexLabel.text = "HEX: # \(colorHex)"
    }
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
        isRGB = true
        isHSB = false
        isP3RGB = false
      setupRGB()
    case 1:
        isP3RGB = true
        isRGB = false
        isHSB = false
      setupRGB()
    case 2:
        isHSB = true
        isRGB = false
        isP3RGB = false
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
    sliderOne.value = 0.0
    sliderTwo.value = 0.0
    sliderThree.value = 0.0
    hexLabel.text = "HEX: #"
    UIView.animate(withDuration: 2) {
      self.view.backgroundColor = .bitterSweet
      self.colorname.isHidden = true
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
  fileprivate func setupColors(colorname: String?) {
    //set color name and backgroud view
    guard let colorname = colorname else { return }
    self.colorname.text = colorname.uppercased()
    self.colorname.isHidden = false
    UIView.animate(withDuration: 2) {
      self.view.backgroundColor = self.calculateColor()
        self.colorView.backgroundColor = self.calculateColor()
    }

    //set lables to inverse Color so they are visible after backgroundColor change.
    //check if RGB mode is active then selecte correct inverse function.
    self.colorname.textColor =
      isRGB||isP3RGB ? calculateColor().inverseRGBColor() : calculateColor().inverseHSBColor()
    sliderOneLable.textColor =
      isRGB||isP3RGB  ? calculateColor().inverseRGBColor() : calculateColor().inverseHSBColor()
    sliderTwoLable.textColor =
      isRGB||isP3RGB  ? calculateColor().inverseRGBColor() : calculateColor().inverseHSBColor()
    sliderThreeLable.textColor =
      isRGB||isP3RGB  ? calculateColor().inverseRGBColor() : calculateColor().inverseHSBColor()
    sliderOneValue.textColor =
      isRGB||isP3RGB  ? calculateColor().inverseRGBColor() : calculateColor().inverseHSBColor()
    sliderTwoValue.textColor =
      isRGB||isP3RGB  ? calculateColor().inverseRGBColor() : calculateColor().inverseHSBColor()
    sliderThreeValue.textColor =
      isRGB||isP3RGB  ? calculateColor().inverseRGBColor() : calculateColor().inverseHSBColor()
    hexLabel.textColor =
        isRGB||isP3RGB  ? calculateColor().inverseRGBColor() : calculateColor().inverseHSBColor()
    saveUserColors()
  }

}

// MARK: UserDefaults funcitons to save User Colors
extension ColorViewController {

    fileprivate func getUserSavedColors() {
        guard let colorname = defaults.string(forKey: "colorname") else { return }
        self.colorname.isHidden = false
        self.colorname.text = colorname
        guard let backgroundColor = defaults.color(forKey: "appColor") else { return }
        self.view.backgroundColor = backgroundColor
        self.colorView.backgroundColor = backgroundColor
    }

    fileprivate func saveUserColors() {
        // save current background Color
        defaults.set(color: self.view.backgroundColor, forKey: "appColor")
        // current color name
        defaults.set(colorname.text, forKey: "colorname")
    }

    fileprivate func clearUserSavedColors() {
        // remove saved background Color
        defaults.removeObject(forKey: "appColor")
        // remove saved color name
        defaults.removeObject(forKey: "colorname")
    }

}


// MARK: Color Calculator funciton
extension ColorViewController {
  fileprivate func calculateColor() -> UIColor {
    if isRGB {
      // Genrate RGB color
      return UIColor(
        rgbColorCodeRed: sliderOne.value, green: sliderTwo.value, blue: sliderThree.value)
    } else if isP3RGB{
        // Genrate P3RGB color
        return UIColor(
            p3rgbColorCodeRed: sliderOne.value, green: sliderTwo.value, blue: sliderThree.value)
    }else {
      // Genrate HSB color
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
extension ColorViewController {
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
