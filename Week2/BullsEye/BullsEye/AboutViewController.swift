//
//  AboutViewController.swift
//  BullsEye
//
//  Created by Franklin Byaruhanga on 08/06/2020.
//  Copyright © 2020 Ray Wenderlich. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {
    @IBOutlet weak var aboutGame: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        dispplayAboutText()
    }
    
    @IBAction func close(_ sender: Any) {
        presentingViewController?.dismiss(animated: true, completion: nil)
    }


fileprivate func dispplayAboutText() {
    // Create the attributed string
    let aboutText = NSMutableAttributedString(string:"Bull\'s Eye\nWelcome to the awesome game of Bull\'s Eye where you can win points and fame by draggingthe slider.\n\nYour goal is to place the slider as close as possible to the target value. The closer you are, the more points you score. Enjoy!\n\nFrom: Franklin B\nRaywenderlich Ios Bootcamp\n")

    // Declare the fonts
    let myStringFont1 = UIFont(name:"ArialRoundedMTBold", size:24.0)!
    let myStringFont2 = UIFont(name:"MarkerFelt-Thin", size:24.0)!
    let myStringFont3 = UIFont(name:"Zapfino", size:24.0)!
    let myStringFont4 = UIFont(name:"Papyrus", size:36.0)!

    // Declare the colors
    let myStringColor1 = UIColor(red: 0.292745, green: 0.461693, blue: 0.998524, alpha: 1.000000)
    let myStringColor2 = UIColor(red: 1.000000, green: 0.000000, blue: 0.000000, alpha: 1.000000)
    let myStringColor3 = UIColor(red: 0.000000, green: 0.000000, blue: 1.000000, alpha: 1.000000)
    let myStringColor4 = UIColor(red: 0.531727, green: 0.000000, blue: 1.000000, alpha: 1.000000)
    let myStringColor5 = UIColor(red: 0.869441, green: 0.000000, blue: 1.000000, alpha: 1.000000)
    let myStringColor6 = UIColor(red: 0.000000, green: 0.000000, blue: 0.000000, alpha: 1.000000)

    // Declare the paragraph styles
    let myStringParaStyle1 = NSMutableParagraphStyle()
    myStringParaStyle1.alignment = NSTextAlignment.center
    myStringParaStyle1.tabStops = [NSTextTab(textAlignment: NSTextAlignment.left, location: 28.000000, options: [:]), NSTextTab(textAlignment: NSTextAlignment.left, location: 56.000000, options: [:]), NSTextTab(textAlignment: NSTextAlignment.left, location: 84.000000, options: [:]), NSTextTab(textAlignment: NSTextAlignment.left, location: 112.000000, options: [:]), NSTextTab(textAlignment: NSTextAlignment.left, location: 140.000000, options: [:]), NSTextTab(textAlignment: NSTextAlignment.left, location: 168.000000, options: [:]), NSTextTab(textAlignment: NSTextAlignment.left, location: 196.000000, options: [:]), NSTextTab(textAlignment: NSTextAlignment.left, location: 224.000000, options: [:]), NSTextTab(textAlignment: NSTextAlignment.left, location: 252.000000, options: [:]), NSTextTab(textAlignment: NSTextAlignment.left, location: 280.000000, options: [:]), NSTextTab(textAlignment: NSTextAlignment.left, location: 308.000000, options: [:]), NSTextTab(textAlignment: NSTextAlignment.left, location: 336.000000, options: [:]), ]


    // Create the attributes and add them to the string
    aboutText.addAttribute(NSAttributedString.Key.font, value:myStringFont1, range:NSRange(location: 0, length: 10))
    aboutText.addAttribute(NSAttributedString.Key.underlineColor, value:myStringColor1, range:NSRange(location: 0, length: 10))
    aboutText.addAttribute(NSAttributedString.Key.underlineStyle, value:1, range:NSRange(location: 0, length: 10))
    aboutText.addAttribute(NSAttributedString.Key.paragraphStyle, value:myStringParaStyle1, range:NSRange(location: 0, length: 10))
    aboutText.addAttribute(NSAttributedString.Key.foregroundColor, value:myStringColor2, range:NSRange(location: 0, length: 10))
    aboutText.addAttribute(NSAttributedString.Key.paragraphStyle, value:myStringParaStyle1, range:NSRange(location: 10, length: 1))
    aboutText.addAttribute(NSAttributedString.Key.underlineStyle, value:1, range:NSRange(location: 10, length: 1))
    aboutText.addAttribute(NSAttributedString.Key.font, value:myStringFont1, range:NSRange(location: 10, length: 1))
    aboutText.addAttribute(NSAttributedString.Key.underlineColor, value:myStringColor1, range:NSRange(location: 10, length: 1))
    aboutText.addAttribute(NSAttributedString.Key.font, value:myStringFont2, range:NSRange(location: 11, length: 100))
    aboutText.addAttribute(NSAttributedString.Key.underlineColor, value:myStringColor1, range:NSRange(location: 11, length: 100))
    aboutText.addAttribute(NSAttributedString.Key.foregroundColor, value:myStringColor3, range:NSRange(location: 11, length: 100))
    aboutText.addAttribute(NSAttributedString.Key.paragraphStyle, value:myStringParaStyle1, range:NSRange(location: 11, length: 100))
    aboutText.addAttribute(NSAttributedString.Key.underlineStyle, value:1, range:NSRange(location: 11, length: 100))
    aboutText.addAttribute(NSAttributedString.Key.foregroundColor, value:myStringColor4, range:NSRange(location: 111, length: 129))
    aboutText.addAttribute(NSAttributedString.Key.font, value:myStringFont2, range:NSRange(location: 111, length: 129))
    aboutText.addAttribute(NSAttributedString.Key.underlineColor, value:myStringColor1, range:NSRange(location: 111, length: 129))
    aboutText.addAttribute(NSAttributedString.Key.paragraphStyle, value:myStringParaStyle1, range:NSRange(location: 111, length: 129))
    aboutText.addAttribute(NSAttributedString.Key.underlineStyle, value:1, range:NSRange(location: 111, length: 129))
    aboutText.addAttribute(NSAttributedString.Key.font, value:myStringFont2, range:NSRange(location: 240, length: 1))
    aboutText.addAttribute(NSAttributedString.Key.underlineColor, value:myStringColor1, range:NSRange(location: 240, length: 1))
    aboutText.addAttribute(NSAttributedString.Key.foregroundColor, value:myStringColor5, range:NSRange(location: 240, length: 1))
    aboutText.addAttribute(NSAttributedString.Key.paragraphStyle, value:myStringParaStyle1, range:NSRange(location: 240, length: 1))
    aboutText.addAttribute(NSAttributedString.Key.underlineStyle, value:1, range:NSRange(location: 240, length: 1))
    aboutText.addAttribute(NSAttributedString.Key.underlineColor, value:myStringColor1, range:NSRange(location: 241, length: 6))
    aboutText.addAttribute(NSAttributedString.Key.font, value:myStringFont1, range:NSRange(location: 241, length: 6))
    aboutText.addAttribute(NSAttributedString.Key.foregroundColor, value:myStringColor6, range:NSRange(location: 241, length: 6))
    aboutText.addAttribute(NSAttributedString.Key.paragraphStyle, value:myStringParaStyle1, range:NSRange(location: 241, length: 6))
    aboutText.addAttribute(NSAttributedString.Key.underlineStyle, value:1, range:NSRange(location: 241, length: 6))
    aboutText.addAttribute(NSAttributedString.Key.foregroundColor, value:myStringColor2, range:NSRange(location: 247, length: 11))
    aboutText.addAttribute(NSAttributedString.Key.font, value:myStringFont3, range:NSRange(location: 247, length: 11))
    aboutText.addAttribute(NSAttributedString.Key.underlineColor, value:myStringColor1, range:NSRange(location: 247, length: 11))
    aboutText.addAttribute(NSAttributedString.Key.paragraphStyle, value:myStringParaStyle1, range:NSRange(location: 247, length: 11))
    aboutText.addAttribute(NSAttributedString.Key.underlineStyle, value:1, range:NSRange(location: 247, length: 11))
    aboutText.addAttribute(NSAttributedString.Key.font, value:myStringFont4, range:NSRange(location: 258, length: 27))
    aboutText.addAttribute(NSAttributedString.Key.underlineColor, value:myStringColor1, range:NSRange(location: 258, length: 27))
    aboutText.addAttribute(NSAttributedString.Key.paragraphStyle, value:myStringParaStyle1, range:NSRange(location: 258, length: 27))
    aboutText.addAttribute(NSAttributedString.Key.underlineStyle, value:1, range:NSRange(location: 258, length: 27))
    aboutText.addAttribute(NSAttributedString.Key.foregroundColor, value:myStringColor2, range:NSRange(location: 258, length: 27))

     aboutGame.attributedText = aboutText
}

}
