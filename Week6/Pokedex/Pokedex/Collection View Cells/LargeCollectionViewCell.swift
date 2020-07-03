import UIKit

@IBDesignable
class LargeCollectionViewCell: UICollectionViewCell, SelfConfiguringCell {
  @IBOutlet weak var pokemonName: UILabel!
  @IBOutlet weak var pokemonImage: UIImageView!
  @IBOutlet weak var pokemonBaseExp: UILabel!
  @IBOutlet weak var pokemonHeight: UILabel!
  @IBOutlet weak var pokemonWeight: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

  @IBInspectable
  var cornerRadius: CGFloat {
    set { layer.cornerRadius = newValue }
    get { return layer.cornerRadius     }
  }

  func configure(with pokemon:Pokemon) {
    self.pokemonName.text = pokemon.pokemonName
    self.pokemonImage.image = UIImage(named: "\(pokemon.pokemonID)")
    self.pokemonBaseExp.text = pokemon.baseExp.description
    self.pokemonHeight.text = pokemon.height.description
    self.pokemonWeight.text = pokemon.weight.description
  }

}
