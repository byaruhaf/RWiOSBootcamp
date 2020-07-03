import UIKit

class LargeViewController: UIViewController {

  enum Section {
    case main
  }
  var dataSource:UICollectionViewDiffableDataSource<Section, Pokemon>!
  let pokemons = PokemonGenerator.shared.generatePokemons()

  @IBOutlet weak var largeCollection: UICollectionView!{
    didSet {
      // Create Collection View Layout
      largeCollection.collectionViewLayout = configureLayout()

      // Register Episode Collection View Cell
      let LargeCellxib = UINib(nibName: LargeCollectionViewCell.nibName, bundle: .main)
      largeCollection.register(LargeCellxib, forCellWithReuseIdentifier: LargeCollectionViewCell.reuseIdentifier)
    }
  }


    override func viewDidLoad() {
        super.viewDidLoad()
      configureDataSource()
      reloadData()
    }

  // Configure Cell
  func configure<T: SelfConfiguringCell  & ReusableView >(_ cellType: T.Type, with pokemon: Pokemon, for indexPath: IndexPath) -> T {
    guard let cell = largeCollection.dequeueReusableCell(withReuseIdentifier: cellType.reuseIdentifier, for: indexPath) as? T else {
      fatalError("Unable to dequeue \(cellType)")
    }
    cell.configure(with: pokemon)
    return cell
  }

  // Configure Collection View Layout
  func configureLayout() -> UICollectionViewCompositionalLayout {
    let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
    let item = NSCollectionLayoutItem(layoutSize: itemSize)
    item.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 10, bottom: 20, trailing: 10)
    let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.8), heightDimension: .fractionalHeight(1))
    let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
    let section = NSCollectionLayoutSection(group: group)
    section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
    return UICollectionViewCompositionalLayout(section: section)
  }

  // Configure Collection Data Source
  func configureDataSource() {
    dataSource = UICollectionViewDiffableDataSource<Section, Pokemon>(collectionView: largeCollection) { (largeCollection, indexPath, pokemon) -> UICollectionViewCell? in
      self.configure(LargeCollectionViewCell.self, with: pokemon, for: indexPath)
    }
  }

  // load snapshot of Data
  func reloadData() {
    var initialSnapshot = NSDiffableDataSourceSnapshot<Section, Pokemon>()
    initialSnapshot.appendSections([.main])
    initialSnapshot.appendItems(pokemons, toSection: .main)
    dataSource.apply(initialSnapshot)
  }

}
