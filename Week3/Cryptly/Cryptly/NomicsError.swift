import Foundation

enum NomicsError:Error {
  case requestFailed
  case responseUnsuccessful(statusCode: Int)
  case invalidData
  case jsonParsingFailure
  case invalidUrl
}
