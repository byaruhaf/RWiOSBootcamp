/// Copyright (c) 2020 Razeware LLC
/// 
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
/// 
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
/// 
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
/// 
/// This project and source code may use libraries or frameworks that are
/// released under various Open-Source licenses. Use of those libraries and
/// frameworks are governed by their own individual licenses.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import UIKit

class HomeViewController: UIViewController{

  let viewModel = CryptoCurrencyViewModel(cryptoCurrencys: DataGenerator.shared.generateData())

  @IBOutlet weak var view1: UIView!
  @IBOutlet weak var view2: UIView!
  @IBOutlet weak var view3: UIView!
  @IBOutlet weak var view4: UIView!
  @IBOutlet weak var view5: UIView!
  @IBOutlet weak var headingLabel: UILabel!
  @IBOutlet weak var view1TextLabel: UILabel!
  @IBOutlet weak var view2TextLabel: UILabel!
  @IBOutlet weak var view3TextLabel: UILabel!
  @IBOutlet weak var view4TextLabel: UILabel!
  @IBOutlet weak var view5TextLabel: UILabel!
  @IBOutlet weak var view4DataText: UILabel!
  @IBOutlet weak var view5DataText: UILabel!
  @IBOutlet weak var themeSwitch: UISwitch!


  override func viewDidLoad() {
    super.viewDidLoad()
    setupLabels()
    setView1Data()
    setView2Data()
    setView3Data()
    setview4DataText()
    setview5DataText()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    registerForTheme()
    setupTheme()
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    unregisterForTheme()
  }

  func setupLabels() {
    headingLabel.font = UIFont.systemFont(ofSize: 20, weight: .medium)
    view1TextLabel.font = UIFont.systemFont(ofSize: 18, weight: .regular)
    view2TextLabel.font = UIFont.systemFont(ofSize: 18, weight: .regular)
    view4TextLabel.font = UIFont.systemFont(ofSize: 20, weight: .medium)
    view5TextLabel.font = UIFont.systemFont(ofSize: 20, weight: .medium)
  }
  
  func setView1Data() {
    view1TextLabel.text = viewModel.allcurrency()
  }
  
  func setView2Data() {
    view2TextLabel.text = viewModel.increasedCurrency()
  }
  
  func setView3Data() {
    view3TextLabel.text = viewModel.decreasedCurrency()
  }

  func setview4DataText() {
    view4DataText.text = viewModel.mostFallingCurrency()
  }

  func setview5DataText() {
    view5DataText.text = viewModel.mostRisingCurrency()
  }
  


  @IBAction func switchPressed(_ sender: Any) {
    setupTheme()
  }

  fileprivate func setupTheme() {
    if themeSwitch.isOn {
      ThemeManager.shared.currentTheme = DarkTheme()
    }else {
      ThemeManager.shared.currentTheme = LightTheme()
    }
  }

}


extension HomeViewController:Themeable{
  func registerForTheme() {
    NotificationCenter.default.addObserver(self, selector: #selector(themeChanged), name: NSNotification.Name.init("themeChanged"), object: nil)
  }

  func unregisterForTheme() {
    NotificationCenter.default.removeObserver(self)
  }

  @objc func themeChanged() {
    animateBatch1()
  }

  func animateBatch1() {
    UIView.animate(withDuration: 0.2, animations: {
      self.view.backgroundColor = ThemeManager.shared.currentTheme?.backgroundColor
      self.headingLabel.textColor = ThemeManager.shared.currentTheme?.titletextColor
      self.view1.backgroundColor = ThemeManager.shared.currentTheme?.widgetBackgroundColor
        self.view1.layer.borderColor = ThemeManager.shared.currentTheme?.borderColor.cgColor
         self.view1TextLabel.textColor = ThemeManager.shared.currentTheme?.textColor
    }) { (true) in
      self.animateBatch2()
    }
  }

  func animateBatch2() {
    UIView.animate(withDuration: 0.3, animations: {
      self.view2.backgroundColor = ThemeManager.shared.currentTheme?.widgetBackgroundColor
      self.view2.layer.borderColor = ThemeManager.shared.currentTheme?.borderColor.cgColor
      self.view2TextLabel.textColor = ThemeManager.shared.currentTheme?.textColor

    }) { (true) in
      self.animateBatch3()
    }
  }

  func animateBatch3() {
    UIView.animate(withDuration: 0.3, animations: {
      self.view3.backgroundColor = ThemeManager.shared.currentTheme?.widgetBackgroundColor
      self.view3.layer.borderColor = ThemeManager.shared.currentTheme?.borderColor.cgColor
      self.view3TextLabel.textColor = ThemeManager.shared.currentTheme?.textColor

    }) { (true) in
      self.animateBatch4()
    }
  }
  func animateBatch4() {
    UIView.animate(withDuration: 0.2) {
      self.view3.backgroundColor = ThemeManager.shared.currentTheme?.widgetBackgroundColor
      self.view4.backgroundColor = ThemeManager.shared.currentTheme?.widgetBackgroundColor
      self.view5.backgroundColor = ThemeManager.shared.currentTheme?.widgetBackgroundColor
      self.view3.layer.borderColor = ThemeManager.shared.currentTheme?.borderColor.cgColor
      self.view4.layer.borderColor = ThemeManager.shared.currentTheme?.borderColor.cgColor
      self.view5.layer.borderColor = ThemeManager.shared.currentTheme?.borderColor.cgColor
      self.view3TextLabel.textColor = ThemeManager.shared.currentTheme?.textColor
      self.view4TextLabel.textColor = ThemeManager.shared.currentTheme?.downtextColor
      self.view5TextLabel.textColor = ThemeManager.shared.currentTheme?.uptextColor
      self.view4DataText.textColor = ThemeManager.shared.currentTheme?.downtextColor
      self.view5DataText.textColor = ThemeManager.shared.currentTheme?.uptextColor
//      self.view4DataText.textColor = UIColor.systemRed
//      self.view5DataText.textColor = UIColor.systemBlue
//      self.view4TextLabel.textColor = UIColor.systemRed
//      self.view5TextLabel.textColor = UIColor.systemBlue

    }
  }

}
