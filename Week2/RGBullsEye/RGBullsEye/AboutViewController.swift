/*
* Copyright (c) 2015 Razeware LLC
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included in
* all copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
* THE SOFTWARE.
*/

import UIKit

class AboutViewController: UIViewController {
    @IBOutlet weak var aboutGame: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
         dispplayAboutText()
    }

    @IBAction func close(sender: AnyObject) {
    presentingViewController?.dismiss(animated: true, completion: nil)
  }


fileprivate func dispplayAboutText() {
    // Create the attributed string
    let aboutText = NSMutableAttributedString(string:"RGBull\'s Eye\nWelcome to the awesome game of RGBull\'s Eye where you can win points and fame by dragging 3 sliders.\n\nYour goal is to place the sliders as close as possible to the target RGB value. The closer you are, the more points you score. Enjoy!\n\nFrom: Franklin B\nRaywenderlich Ios Bootcamp\n")

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
    aboutText.addAttribute(NSAttributedString.Key.font, value:myStringFont1, range:NSRange(location: 0, length: 12))
    aboutText.addAttribute(NSAttributedString.Key.underlineColor, value:myStringColor1, range:NSRange(location: 0, length: 12))
    aboutText.addAttribute(NSAttributedString.Key.underlineStyle, value:1, range:NSRange(location: 0, length: 12))
    aboutText.addAttribute(NSAttributedString.Key.paragraphStyle, value:myStringParaStyle1, range:NSRange(location: 0, length: 12))
    aboutText.addAttribute(NSAttributedString.Key.foregroundColor, value:myStringColor2, range:NSRange(location: 0, length: 12))
    aboutText.addAttribute(NSAttributedString.Key.paragraphStyle, value:myStringParaStyle1, range:NSRange(location: 12, length: 1))
    aboutText.addAttribute(NSAttributedString.Key.underlineStyle, value:1, range:NSRange(location: 12, length: 1))
    aboutText.addAttribute(NSAttributedString.Key.font, value:myStringFont1, range:NSRange(location: 12, length: 1))
    aboutText.addAttribute(NSAttributedString.Key.underlineColor, value:myStringColor1, range:NSRange(location: 12, length: 1))
    aboutText.addAttribute(NSAttributedString.Key.font, value:myStringFont2, range:NSRange(location: 13, length: 102))
    aboutText.addAttribute(NSAttributedString.Key.underlineColor, value:myStringColor1, range:NSRange(location: 13, length: 102))
    aboutText.addAttribute(NSAttributedString.Key.foregroundColor, value:myStringColor3, range:NSRange(location: 13, length: 102))
    aboutText.addAttribute(NSAttributedString.Key.paragraphStyle, value:myStringParaStyle1, range:NSRange(location: 13, length: 102))
    aboutText.addAttribute(NSAttributedString.Key.underlineStyle, value:1, range:NSRange(location: 13, length: 102))
    aboutText.addAttribute(NSAttributedString.Key.foregroundColor, value:myStringColor4, range:NSRange(location: 115, length: 134))
    aboutText.addAttribute(NSAttributedString.Key.font, value:myStringFont2, range:NSRange(location: 115, length: 134))
    aboutText.addAttribute(NSAttributedString.Key.underlineColor, value:myStringColor1, range:NSRange(location: 115, length: 134))
    aboutText.addAttribute(NSAttributedString.Key.paragraphStyle, value:myStringParaStyle1, range:NSRange(location: 115, length: 134))
    aboutText.addAttribute(NSAttributedString.Key.underlineStyle, value:1, range:NSRange(location: 115, length: 134))
    aboutText.addAttribute(NSAttributedString.Key.font, value:myStringFont2, range:NSRange(location: 249, length: 1))
    aboutText.addAttribute(NSAttributedString.Key.underlineColor, value:myStringColor1, range:NSRange(location: 249, length: 1))
    aboutText.addAttribute(NSAttributedString.Key.foregroundColor, value:myStringColor5, range:NSRange(location: 249, length: 1))
    aboutText.addAttribute(NSAttributedString.Key.paragraphStyle, value:myStringParaStyle1, range:NSRange(location: 249, length: 1))
    aboutText.addAttribute(NSAttributedString.Key.underlineStyle, value:1, range:NSRange(location: 249, length: 1))
    aboutText.addAttribute(NSAttributedString.Key.underlineColor, value:myStringColor1, range:NSRange(location: 250, length: 6))
    aboutText.addAttribute(NSAttributedString.Key.font, value:myStringFont1, range:NSRange(location: 250, length: 6))
    aboutText.addAttribute(NSAttributedString.Key.foregroundColor, value:myStringColor6, range:NSRange(location: 250, length: 6))
    aboutText.addAttribute(NSAttributedString.Key.paragraphStyle, value:myStringParaStyle1, range:NSRange(location: 250, length: 6))
    aboutText.addAttribute(NSAttributedString.Key.underlineStyle, value:1, range:NSRange(location: 250, length: 6))
    aboutText.addAttribute(NSAttributedString.Key.foregroundColor, value:myStringColor2, range:NSRange(location: 256, length: 11))
    aboutText.addAttribute(NSAttributedString.Key.font, value:myStringFont3, range:NSRange(location: 256, length: 11))
    aboutText.addAttribute(NSAttributedString.Key.underlineColor, value:myStringColor1, range:NSRange(location: 256, length: 11))
    aboutText.addAttribute(NSAttributedString.Key.paragraphStyle, value:myStringParaStyle1, range:NSRange(location: 256, length: 11))
    aboutText.addAttribute(NSAttributedString.Key.underlineStyle, value:1, range:NSRange(location: 256, length: 11))
    aboutText.addAttribute(NSAttributedString.Key.font, value:myStringFont4, range:NSRange(location: 267, length: 27))
    aboutText.addAttribute(NSAttributedString.Key.underlineColor, value:myStringColor1, range:NSRange(location: 267, length: 27))
    aboutText.addAttribute(NSAttributedString.Key.paragraphStyle, value:myStringParaStyle1, range:NSRange(location: 267, length: 27))
    aboutText.addAttribute(NSAttributedString.Key.underlineStyle, value:1, range:NSRange(location: 267, length: 27))
    aboutText.addAttribute(NSAttributedString.Key.foregroundColor, value:myStringColor2, range:NSRange(location: 267, length: 27))
     aboutGame.attributedText = aboutText
}

}
