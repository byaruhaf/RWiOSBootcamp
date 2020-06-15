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

  typealias CryptoCompletionHandler = (Result<[CryptoCurrency], NomicsError>) -> Void

  func getCryptoData(completionHandler completion: @escaping CryptoCompletionHandler) {

    let request = URLRequest(url: url)

    let task = session.dataTask(with: request) { (data, response, error) in
      DispatchQueue.main.async {//main start
        guard let httpResponse = response as? HTTPURLResponse else {
          completion(.failure(NomicsError.requestFailed))
          return
        }
        if httpResponse.statusCode == 200 {
          if let data = data {
            do {
              let cryptoCurrency = try self.decoder.decode([CryptoCurrency].self, from: data)
              completion(.success(cryptoCurrency))
            } catch {
              completion(.failure(NomicsError.jsonParsingFailure))
            }
          } else {
            completion(.failure(NomicsError.invalidData))
          }
        } else {
          completion(.failure(NomicsError.responseUnsuccessful(statusCode: httpResponse.statusCode)))
        }
      } //main end
    }
    task.resume()
  }


}
