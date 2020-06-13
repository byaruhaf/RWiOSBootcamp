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

import Foundation
import UIKit.UIColor

protocol Theme {
  var backgroundColor: UIColor { get }
  var textColor: UIColor { get }
  var borderColor: UIColor { get }
  var widgetBackgroundColor: UIColor { get }
  var downtextColor: UIColor { get }
  var uptextColor: UIColor { get }
  var titletextColor: UIColor { get }
}

protocol Themeable {
  func registerForTheme()
  func unregisterForTheme()
  func themeChanged()
}

struct DarkTheme: Theme {
  let borderColor: UIColor = .yellow
  let backgroundColor: UIColor = .black
   let textColor: UIColor = UIColor(red:0.999, green:0.494, blue:0.000, alpha:1.000)
   let widgetBackgroundColor: UIColor = UIColor(red:0.114, green:0.114, blue:0.114, alpha:1.000)
  let downtextColor: UIColor = .systemRed
  let uptextColor: UIColor = .systemBlue
  let titletextColor: UIColor = UIColor(red:0.999, green:0.494, blue:0.000, alpha:1.000)
}

struct LightTheme: Theme {
  let borderColor: UIColor = UIColor(red:0.145, green:0.127, blue:0.210, alpha:1.000)
  let backgroundColor: UIColor = UIColor(red:0.145, green:0.127, blue:0.210, alpha:1.000)
  let textColor: UIColor = .white
  let widgetBackgroundColor: UIColor = UIColor(red:0.223, green:0.205, blue:0.297, alpha:1.000)
  let downtextColor: UIColor = UIColor(red:0.920, green:0.341, blue:0.403, alpha:1.000)
  let uptextColor: UIColor = .systemBlue
  let titletextColor: UIColor = .white
}
