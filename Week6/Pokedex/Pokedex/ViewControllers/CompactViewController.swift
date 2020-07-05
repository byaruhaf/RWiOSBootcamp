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
      let CompactCellxib = UINib(nibName: CompactCollectionViewCell.nibName, bundle: .main)
      compactCollection.register(CompactCellxib, forCellWithReuseIdentifier: CompactCollectionViewCell.reuseIdentifier)
    }
  }
    
    override func viewDidLoad() {
        super.viewDidLoad()
      configureDataSource()
      reloadData()

    }
  // Configure Cell
  func configure<T: SelfConfiguringCell  & ReusableView >(_ cellType: T.Type, with pokemon: Pokemon, for indexPath: IndexPath) -> T {
    guard let cell = compactCollection.dequeueReusableCell(withReuseIdentifier: cellType.reuseIdentifier, for: indexPath) as? T else {
      fatalError("Unable to dequeue \(cellType)")
    }
    cell.configure(with: pokemon)
    return cell
  }



  // Configure Collection Data Source
  func configureDataSource() {
    dataSource = UICollectionViewDiffableDataSource<Section, Pokemon>(collectionView: compactCollection) { (compactCollection, indexPath, pokemon) -> UICollectionViewCell? in
      self.configure(CompactCollectionViewCell.self, with: pokemon, for: indexPath)
    }
  }
  
  // load snapshot of Data
  func reloadData() {
    var snapshot = NSDiffableDataSourceSnapshot<Section, Pokemon>()
    snapshot.appendSections([.main])
    snapshot.appendItems(pokemons, toSection: .main)
    dataSource.apply(snapshot)
  }

}

// MARK: - Layout
extension CompactViewController {
  // Configure Collection View Layout
  private func configureLayout() -> UICollectionViewCompositionalLayout {
    let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(0.33))
    let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 3)

    let section = NSCollectionLayoutSection(group: group)
    return UICollectionViewCompositionalLayout(section: section)
  }
}
