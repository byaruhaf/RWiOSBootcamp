import UIKit


class CompactViewController:UIViewController {

  enum Section {
    case main
  }
  var dataSource:UICollectionViewDiffableDataSource<Section, Pokemon>!
  let pokemons = PokemonGenerator.shared.generatePokemons()

  @IBOutlet weak var compactCollection: UICollectionView!{
    didSet {
      // Create Collection View Layout
      compactCollection.collectionViewLayout = configureLayout()

      // Register Episode Collection View Cell
      let xib = UINib(nibName: CompactCollectionViewCell.nibName, bundle: .main)
      compactCollection.register(xib, forCellWithReuseIdentifier: CompactCollectionViewCell.reuseIdentifier)
    }
  }
    
    override func viewDidLoad() {
        super.viewDidLoad()
      configureDataSource()

    }

  func configureLayout() -> UICollectionViewCompositionalLayout {
    let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/3), heightDimension: .fractionalHeight(1.0))
    let item = NSCollectionLayoutItem(layoutSize: itemSize)
    item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
    let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(0.33))
    let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
    let section = NSCollectionLayoutSection(group: group)
    return UICollectionViewCompositionalLayout(section: section)
  }

  func configureDataSource() {
    dataSource = UICollectionViewDiffableDataSource<Section, Pokemon>(collectionView: compactCollection) { (compactCollection, indexPath, number) -> UICollectionViewCell? in
      guard let cell = compactCollection.dequeueReusableCell(withReuseIdentifier: CompactCollectionViewCell.reuseIdentifier, for: indexPath) as?  CompactCollectionViewCell else {
        fatalError("Cannot create new cell")
      }
      cell.pokemonName.text = self.pokemons[indexPath.row].pokemonName
      cell.pokemonImage.image = UIImage(named: "\(self.pokemons[indexPath.row].pokemonID)")
      return cell
    }

    var initialSnapshot = NSDiffableDataSourceSnapshot<Section, Pokemon>()
    initialSnapshot.appendSections([.main])
    initialSnapshot.appendItems(pokemons, toSection: .main)
    dataSource.apply(initialSnapshot, animatingDifferences: false, completion: nil)

  }

}
