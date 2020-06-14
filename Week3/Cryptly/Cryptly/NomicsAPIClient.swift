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

class NomicsAPIClient {
  fileprivate let NomicsAPIKey = "d1a90a4dfeaa4047300f749853ac7501"
  lazy var baseURL: URL = {
    return URL(string: "https://api.nomics.com/v1/currencies/ticker?key=\(NomicsAPIKey)&ids=BTC,ETH,TRN,LTC,XRP,NXT&interval=1d,30d")!
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
