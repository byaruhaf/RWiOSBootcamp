import Foundation

class CryptoCurrencyViewModel {

 let cryptoCurrencys:[CryptoCurrency]?

  init(cryptoCurrencys:[CryptoCurrency]?) {
    self.cryptoCurrencys = cryptoCurrencys
  }

  func allcurrency() -> String? {
    guard let cryptoCurrencys = cryptoCurrencys else { return nil}
    let  allcurrencys = cryptoCurrencys.reduce(""){$0 + $1.symbol + ", "}
    return String(allcurrencys.dropLast(2))
  }

  func increasedCurrency() -> String? {
     guard let cryptoCurrencys = cryptoCurrencys else { return nil}
    let  increasedCurrenies = cryptoCurrencys.filter { $0._30d.trend == .rising }.reduce(""){$0 + $1.name + ", " }
    return String(increasedCurrenies.dropLast(2))
  }

  func decreasedCurrency() -> String? {
     guard let cryptoCurrencys = cryptoCurrencys else { return nil}
    let  decreasedCurrenies =  cryptoCurrencys.filter { $0._30d.trend == .falling }.reduce(""){$0 + $1.name + ", " }
     return String(decreasedCurrenies.dropLast(2))
  }

  func CurrencyRiseFallCalculation() -> (riseSymbol:String,riseValue:String,fallSymbol:String,fallValue:String)? {
    guard let cryptoCurrencys = cryptoCurrencys else { return nil}
    let cryptoRiseDict = cryptoCurrencys.reduce(into: [String: Double]()) { $0[$1.symbol] = $1._30d.percentageRise}
    let mostRisingCurrencyopt = cryptoRiseDict.max { a, b in a.value < b.value }
     guard let mostRisingCurrency = mostRisingCurrencyopt else { return nil}
    let riseValue = String(format: "%.05f", (mostRisingCurrency.value))
    let riseSymbol = mostRisingCurrency.key
    let mostFallingCurrencyopt = cryptoRiseDict.min { a, b in a.value < b.value }
    guard let mostFallingCurrency = mostFallingCurrencyopt else { return nil}
    let fallValue = String(format: "%.05f", (mostFallingCurrency.value))
    let fallSymbol = mostFallingCurrency.key
    return (riseSymbol,riseValue,fallSymbol,fallValue)
  }


}
