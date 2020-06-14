import Foundation

//struct CryptoCurrency: Codable {
//  let name: String
//  let symbol: String
//  let currentValue: Int
//  let previousValue: Int
//  var trend:Trend {
//    currentValue > previousValue ? .rising:.falling
//  }
//  var percentageRise:Float  {
//    (Float(currentValue - previousValue) / Float(previousValue)) * 100
//  }
//}

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

  func mostRisingCurrency() -> (cryptoSymbol:String,value:String)? {
    guard let cryptoCurrencys = cryptoCurrencys else { return nil}
    let cryptoRiseDict = cryptoCurrencys.reduce(into: [String: Double]()) { $0[$1.symbol] = $1._30d.percentageRise}
    let mostRisingCurrency = cryptoRiseDict.max { a, b in a.value < b.value }
    let value = String(format: "%.05f", (mostRisingCurrency?.value)!)
    let cryptoSymbol = mostRisingCurrency?.key
    return (cryptoSymbol!,value)
  }

  func mostFallingCurrency() -> (cryptoSymbol:String,value:String)? {
    guard let cryptoCurrencys = cryptoCurrencys else { return nil}
    let cryptoRiseDict = cryptoCurrencys.reduce(into: [String: Double]()) { $0[$1.symbol] = $1._30d.percentageRise}
    let mostRisingCurrency = cryptoRiseDict.min { a, b in a.value < b.value }
    let value = String(format: "%.05f", (mostRisingCurrency?.value)!)
    let cryptoSymbol = mostRisingCurrency?.key
    return (cryptoSymbol!,value)
  }

}
