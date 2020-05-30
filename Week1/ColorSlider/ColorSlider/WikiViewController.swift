//
//  WikiViewController.swift
//  ColorSlider
//
//  Created by Franklin Byaruhanga on 29/05/2020.
//  Copyright © 2020 Franklin Byaruhanga. All rights reserved.
//

import UIKit
import WebKit

class WikiViewController: UIViewController, WKUIDelegate {
  @IBOutlet weak var wikiWeb: WKWebView!
  var wikiURL: URL?

  override func viewDidLoad() {
    super.viewDidLoad()
    loadWiki()
  }

  @IBAction func closeWiki(_ sender: Any) {
    self.dismiss(animated: true, completion: nil)
  }

  fileprivate func loadWiki() {
    // Do any additional setup after loading the view.
    guard let wikiURL = wikiURL else { return }
    wikiWeb.load(URLRequest(url: wikiURL))
    wikiWeb.allowsBackForwardNavigationGestures = true
  }

}
