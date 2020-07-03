import UIKit

@IBDesignable
class CompactCollectionViewCell: UICollectionViewCell, SelfConfiguringCell {

  @IBOutlet weak var pokemonImage: UIImageView!
  @IBOutlet weak var pokemonName: UILabel!
  override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

  func configure(with pokemon:Pokemon) {
    self.pokemonName.text = pokemon.pokemonName
    self.pokemonImage.image = UIImage(named: "\(pokemon.pokemonID)")
  }

  @IBInspectable
  var cornerRadius: CGFloat {
    set { layer.cornerRadius = newValue }
    get { return layer.cornerRadius     }
  }

}
