import Foundation

class NomicsAPIClient {
  fileprivate let NomicsAPIKey = "d1a90a4dfeaa4047300f749853ac7501"

  let searchTerm = "BTC,ETH,LTC,XRP,NXT,ADA"
  let periodRange = "30d"

  var url: URL {
    var components = URLComponents()
    components.scheme = "https"
    components.host = "api.nomics.com"
    components.path = "/v1/currencies/ticker"
    components.queryItems = [
      URLQueryItem(name: "key", value: NomicsAPIKey),
      URLQueryItem(name: "ids", value: searchTerm),
      URLQueryItem(name: "interval", value: periodRange)
    ]
    guard let url = components.url else {
      preconditionFailure(
        "Invalid URL components: \(components)"
      )
    }
    return url
  }

  let decoder = JSONDecoder()
  let session = URLSession(configuration: .default)

  typealias CryptoCompletionHandler = ([CryptoCurrency]?, Error?) -> Void

  func getCryptoData(completionHandler completion: @escaping CryptoCompletionHandler) {

    let request = URLRequest(url: url)

    let task = session.dataTask(with: request) { (data, response, error) in
      DispatchQueue.main.async {
        if let data = data {
          guard let httpResponse = response as? HTTPURLResponse else {
            completion(nil, NomicsError.requestFailed)
            return
          }
          if httpResponse.statusCode == 200 {
            do {
              let cryptoCurrency = try self.decoder.decode([CryptoCurrency].self, from: data)
              completion(cryptoCurrency, nil)
            } catch {
              completion(nil, NomicsError.invalidData)
            }
          } else {
            completion(nil, error)
          }

        } else if let error = error {
          completion(nil, error)
        }
      }
    }
    task.resume()
  }

}
