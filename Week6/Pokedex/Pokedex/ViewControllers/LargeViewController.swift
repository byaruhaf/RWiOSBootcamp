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
      let xib = UINib(nibName: LargeCollectionViewCell.nibName, bundle: .main)
      largeCollection.register(xib, forCellWithReuseIdentifier: LargeCollectionViewCell.reuseIdentifier)
    }
  }


    override func viewDidLoad() {
        super.viewDidLoad()
      configureDataSource()
    }

  func configureLayout() -> UICollectionViewCompositionalLayout {
    let itemSize = NSCollectionLayoutSize(widthDimension: NSCollectionLayoutDimension.fractionalWidth(1.0), heightDimension: NSCollectionLayoutDimension.fractionalHeight(1.0))
    let item = NSCollectionLayoutItem(layoutSize: itemSize)
    item.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 10, bottom: 20, trailing: 10)
    let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.8), heightDimension: .fractionalHeight(1))
    let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])

    let section = NSCollectionLayoutSection(group: group)
    section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
    return UICollectionViewCompositionalLayout(section: section)
  }

  func configureDataSource() {
    dataSource = UICollectionViewDiffableDataSource<Section, Pokemon>(collectionView: largeCollection) { (largeCollection, indexPath, number) -> UICollectionViewCell? in
      guard let cell = largeCollection.dequeueReusableCell(withReuseIdentifier: LargeCollectionViewCell.reuseIdentifier, for: indexPath) as?  LargeCollectionViewCell else {
        fatalError("Cannot create new cell")
      }

      let pokemon = self.pokemons[indexPath.row]

      cell.pokemonName.text = pokemon.pokemonName
      cell.pokemonImage.image = UIImage(named: "\(pokemon.pokemonID)")
      cell.pokemonBaseExp.text = pokemon.baseExp.description
      cell.pokemonHeight.text = pokemon.height.description
      cell.pokemonWeight.text = pokemon.weight.description
      
      return cell
    }

    var initialSnapshot = NSDiffableDataSourceSnapshot<Section, Pokemon>()
    initialSnapshot.appendSections([.main])
    initialSnapshot.appendItems(pokemons, toSection: .main)
    dataSource.apply(initialSnapshot, animatingDifferences: false, completion: nil)

  }

}
