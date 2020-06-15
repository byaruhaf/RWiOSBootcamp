import Foundation

enum Trend: Int, Codable{
  case rising,falling
}

struct CryptoCurrency: Codable {
  let id: String
  let currency: String
  let symbol: String
  let name: String
  let logoUrl: URL
  let price: String
  let priceDate: String
  let priceTimestamp: String
  struct __30d: Codable {
    let priceChange: String
    let priceChangePct: String
    var trend:Trend? {
      guard let priceChangePct = Double(self.priceChangePct) else { return nil }
      return priceChangePct.isLess(than: 0.000000000) ? Trend.falling:Trend.rising
    }
    var percentageRise:Double?  {
      guard let priceChangePct = Double(self.priceChangePct) else { return nil }
      return priceChangePct
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
    case _30d = "30d"
  }
}
