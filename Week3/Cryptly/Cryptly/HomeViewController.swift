import UIKit

class HomeViewController: UIViewController {

  let client = NomicsAPIClient()

  let viewModel = CryptoCurrencyViewModel(cryptoCurrencys: DataGenerator.shared.generateData())

//  var viewModel:[CryptoCurrencyViewModel] = []

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
  @IBOutlet weak var view4Image: UIImageView!
  @IBOutlet weak var view5DataText: UILabel!
  @IBOutlet weak var view5Image: UIImageView!
  @IBOutlet weak var themeSwitch: UISwitch!

  override func viewDidLoad() {
    super.viewDidLoad()
    setupLabels()
    getData()
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

  func getData() {
    client.getCryptoData { [unowned self] currentCyptoData, error in
      if let currentCyptoData = currentCyptoData {
        let viewModel = CryptoCurrencyViewModel(cryptoCurrencys: currentCyptoData)
        self.updateViewData(viewModel:viewModel)
      }
    }
  }

  func updateViewData(viewModel:CryptoCurrencyViewModel) {
    view1TextLabel.text = viewModel.allcurrency()
    view2TextLabel.text = viewModel.increasedCurrency()
    view3TextLabel.text = viewModel.decreasedCurrency()
    view4DataText.text = viewModel.mostFallingCurrency()?.value
    view4TextLabel.text = "Most Rising: \(viewModel.mostFallingCurrency()!.cryptoSymbol)"
    view5DataText.text = viewModel.mostRisingCurrency()?.value
    view5TextLabel.text = "Most Rising: \(viewModel.mostRisingCurrency()!.cryptoSymbol)"
  }

  @IBAction func switchPressed(_ sender: Any) {
    setupTheme()
  }

  fileprivate func setupTheme() {
    if themeSwitch.isOn {
      ThemeManager.shared.currentTheme = DarkTheme()
    } else {
      ThemeManager.shared.currentTheme = LightTheme()
    }
  }
}

extension HomeViewController: Themeable {
  func registerForTheme() {
    NotificationCenter.default.addObserver(
      self, selector: #selector(themeChanged), name: NSNotification.Name.init("themeChanged"),
      object: nil)
  }

  func unregisterForTheme() {
    NotificationCenter.default.removeObserver(self)
  }

  @objc func themeChanged() {
    animateBatch1()
  }

  func animateBatch1() {
    UIView.animate(
      withDuration: 0.2,
      animations: {
        self.view.backgroundColor = ThemeManager.shared.currentTheme?.backgroundColor
        self.headingLabel.textColor = ThemeManager.shared.currentTheme?.titletextColor
        self.view1.backgroundColor = ThemeManager.shared.currentTheme?.widgetBackgroundColor
        self.view1.layer.borderColor = ThemeManager.shared.currentTheme?.borderColor.cgColor
        self.view1TextLabel.textColor = ThemeManager.shared.currentTheme?.textColor
      }
    ) { (true) in
      self.animateBatch2()
    }
  }

  func animateBatch2() {
    UIView.animate(
      withDuration: 0.3,
      animations: {
        self.view2.backgroundColor = ThemeManager.shared.currentTheme?.widgetBackgroundColor
        self.view2.layer.borderColor = ThemeManager.shared.currentTheme?.borderColor.cgColor
        self.view2TextLabel.textColor = ThemeManager.shared.currentTheme?.textColor
      }
    ) { (true) in
      self.animateBatch3()
    }
  }

  func animateBatch3() {
    UIView.animate(
      withDuration: 0.3,
      animations: {
        self.view3.backgroundColor = ThemeManager.shared.currentTheme?.widgetBackgroundColor
        self.view3.layer.borderColor = ThemeManager.shared.currentTheme?.borderColor.cgColor
        self.view3TextLabel.textColor = ThemeManager.shared.currentTheme?.textColor
      }
    ) { (true) in
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
    }
  }

}
