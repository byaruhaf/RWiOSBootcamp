import Foundation

class DataGenerator {
    static let shared = DataGenerator()
    private init() { }

    func generateData() -> [CryptoCurrency]? {

        if let filePath = Bundle.main.path(forResource: "realData", ofType: "json") {
            let fileURL = URL(fileURLWithPath: filePath)
            do {
                let data = try Data(contentsOf: fileURL)
                let decoder = JSONDecoder()
                let decodedData = try decoder.decode([CryptoCurrency].self, from: data)
                return decodedData
            } catch let error {
                print("Error in parsing \(error.localizedDescription)")
            }
        }
        return nil
    }
}
