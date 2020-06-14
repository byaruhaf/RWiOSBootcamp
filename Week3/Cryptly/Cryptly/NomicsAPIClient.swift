import Foundation

class NomicsAPIClient {
  fileprivate let NomicsAPIKey = "d1a90a4dfeaa4047300f749853ac7501"
  lazy var baseURL: URL = {
    return URL(string: "https://api.nomics.com/v1/currencies/ticker?key=\(NomicsAPIKey)&ids=BTC,ETH,LTC,XRP,NXT&interval=1d,30d")!
  }()


typealias CryptoCompletionHandler = ([CryptoCurrency]?, Error?) -> Void

let decoder = JSONDecoder()

let session: URLSession

init(configuration: URLSessionConfiguration) {
  self.session = URLSession(configuration: configuration)
}

convenience init() {
  self.init(configuration: .default)
}

  func getCryptoData(completionHandler completion: @escaping CryptoCompletionHandler) {

    let url = baseURL

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
