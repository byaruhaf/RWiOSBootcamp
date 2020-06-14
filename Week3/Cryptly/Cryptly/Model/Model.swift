import Foundation

enum Trend: Int, Codable{
  case rising,falling
}

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

struct CryptoCurrency: Codable {
  let id: String
  let currency: String
  let symbol: String
  let name: String
  let logoUrl: URL
  let price: String
  let priceDate: String
  let priceTimestamp: String
  struct __1d: Codable {
    let priceChange: String
    let priceChangePct: String
    var trend:Trend {
      Double(self.priceChangePct)!.isLess(than: 0.000000000) ? .rising:.falling
    }
    var percentageRise:Double  {
      Double(self.priceChangePct)!
    }
    private enum CodingKeys: String, CodingKey {
      case priceChange = "price_change"
      case priceChangePct = "price_change_pct"
    }
  }
  let _1d: __1d
  struct __30d: Codable {
    let priceChange: String
    let priceChangePct: String
    var trend:Trend {
      Double(self.priceChangePct)!.isLess(than: 0.000000000) ? .rising:.falling
    }
    var percentageRise:Double  {
      Double(self.priceChangePct)!
    }
    private enum CodingKeys: String, CodingKey {
      case priceChange = "price_change"
      case priceChangePct = "price_change_pct"
    }
  }
  let _30d: __30d
  private enum CodingKeys: String, CodingKey {
    case id
    case currency
    case symbol
    case name
    case logoUrl = "logo_url"
    case price
    case priceDate = "price_date"
    case priceTimestamp = "price_timestamp"
    case _1d = "1d"
    case _30d = "30d"
  }
}
