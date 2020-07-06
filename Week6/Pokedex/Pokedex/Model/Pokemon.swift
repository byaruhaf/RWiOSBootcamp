import Foundation

struct Pokemon:Hashable {
  var identifier:UUID = UUID()
  var pokemonID:Int
  var pokemonName:String
  var baseExp:Int
  var weight:Int
  var height:Int

  func hash(into hasher: inout Hasher) {
    hasher.combine(identifier)
  }
  static func == (lhs:Pokemon, rhs:Pokemon) -> Bool {
    return lhs.identifier == rhs.identifier
  }
}

