import UIKit


class ComposedViewController: UIViewController {
  enum Section:CaseIterable {
    case top
    case main
  }

  var dataSource:UICollectionViewDiffableDataSource<Section, Pokemon>!
  let pokemons1 = PokemonGenerator.shared.generatePokemons()
  let pokemons2 = PokemonGenerator.shared.generatePokemons()

  @IBOutlet weak var ComposedCollection: UICollectionView!{
    didSet {
      // Create Collection View Layout
      ComposedCollection.collectionViewLayout = createCompositionalLayout()

      // Register Episode Collection View Cell
      let LargeCellxib = UINib(nibName: LargeCollectionViewCell.nibName, bundle: .main)
      ComposedCollection.register(LargeCellxib, forCellWithReuseIdentifier: LargeCollectionViewCell.reuseIdentifier)
      let CompactCellxib = UINib(nibName: CompactCollectionViewCell.nibName, bundle: .main)
      ComposedCollection.register(CompactCellxib, forCellWithReuseIdentifier: CompactCollectionViewCell.reuseIdentifier)
    }
  }
  
    override func viewDidLoad() {
        super.viewDidLoad()
      configureDataSource()
      reloadData()
    }

  // Configure Cell
  func configure<T: SelfConfiguringCell  & ReusableView >(_ cellType: T.Type, with pokemon: Pokemon, for indexPath: IndexPath) -> T {
    guard let cell = ComposedCollection.dequeueReusableCell(withReuseIdentifier: cellType.reuseIdentifier, for: indexPath) as? T else {
      fatalError("Unable to dequeue \(cellType)")
    }
    cell.configure(with: pokemon)
    return cell
  }

  // Configure Data Source based on sections
    func configureDataSource() {
      dataSource = UICollectionViewDiffableDataSource<Section, Pokemon>(collectionView: ComposedCollection) { (ComposedCollection, indexPath, pokemon) -> UICollectionViewCell? in
        let section = Section.allCases[indexPath.section]
        switch section {
          case .top:
            return self.configure(CompactCollectionViewCell.self, with: pokemon, for: indexPath)
          case .main:
            return self.configure(LargeCollectionViewCell.self, with: pokemon, for: indexPath)
        }
      }
    }

// load snapshot of Data in each section
  func reloadData() {
    var snapshot = NSDiffableDataSourceSnapshot<Section, Pokemon>()
    snapshot.appendSections(Section.allCases)
    snapshot.appendItems(pokemons1, toSection: .main)
    snapshot.appendItems(pokemons2, toSection: .top)
    dataSource.apply(snapshot)
  }
}

// MARK: - Layout
extension ComposedViewController {
  // Configure Collection View Layout based on sections
 private func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
    let layout = UICollectionViewCompositionalLayout { (sectionIndex: Int, environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
      let section = Section.allCases[sectionIndex]
      switch section {
        case .top:
          return self.createCompactSection(environment)
        case .main:
          return self.createLargeSection(environment)
      }
    }
    let config = UICollectionViewCompositionalLayoutConfiguration()
    config.interSectionSpacing = 2
    layout.configuration = config
    return layout
  }

  // Configure Compact Section of Collection View
 private func createCompactSection(_ environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection {
  let isIpad = environment.traitCollection.horizontalSizeClass == .regular &&  environment.traitCollection.verticalSizeClass == .regular
  let columns = isIpad ? 6:3
  let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
  let item = NSCollectionLayoutItem(layoutSize: itemSize)
  item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
  let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(0.33))
  let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: columns)
    let section = NSCollectionLayoutSection(group: group)
    section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
    section.contentInsets = NSDirectionalEdgeInsets.init(top:5, leading: 0, bottom: 0, trailing: 0)
    return section
  }

  // Configure Large Section of Collection View
 private func createLargeSection(_ environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection {
    let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
    let item = NSCollectionLayoutItem(layoutSize: itemSize)
    item.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 10, bottom: 20, trailing: 10)
    let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.8), heightDimension: .fractionalHeight(0.8))
    let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
    let section = NSCollectionLayoutSection(group: group)
    section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
    section.contentInsets = NSDirectionalEdgeInsets.init(top: 0, leading: 0, bottom: 20, trailing: 0)
    return section
  }
}
