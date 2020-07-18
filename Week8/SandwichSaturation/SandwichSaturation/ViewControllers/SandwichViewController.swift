//
//  SandwichViewController.swift
//  SandwichSaturation
//
//  Created by Jeff Rames on 7/3/20.
//  Copyright © 2020 Jeff Rames. All rights reserved.
//

import UIKit
import CoreData

protocol SandwichDataSource {
  func saveSandwich(_: SandwichData)
}

class SandwichViewController: UITableViewController, SandwichDataSource, NSFetchedResultsControllerDelegate {
  let searchController = UISearchController(searchResultsController: nil)
  var sandwiches = [SandwichData]()
  var filteredSandwiches = [SandwichData]()
  var persistentContiner = NSPersistentContainer(name: "sandwiches")

    // MARK: -

    private lazy var fetchedResultsController:NSFetchedResultsController<SandwichModel> = {
        // Create Fetch Request
        let fetchRequest: NSFetchRequest<SandwichModel> = SandwichModel.fetchRequest()

        // Configure Fetch Request
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: #keyPath(SandwichModel.name), ascending: false)]

        // Create Fetched Results Controller
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.persistentContiner.viewContext, sectionNameKeyPath: nil, cacheName: nil)

        // Configure Fetched Results Controller
        fetchedResultsController.delegate = self

        return fetchedResultsController
    }()

  required init?(coder: NSCoder) {
    super.init(coder: coder)
    
    loadSandwiches()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(presentAddView(_:)))
    navigationItem.rightBarButtonItem = addButton
    
    // Setup Search Controller
    searchController.searchResultsUpdater = self
    searchController.obscuresBackgroundDuringPresentation = false
    searchController.searchBar.placeholder = "Filter Sandwiches"
    navigationItem.searchController = searchController
    definesPresentationContext = true
    searchController.searchBar.scopeButtonTitles = SauceAmount.allCases.map { $0.rawValue }
    searchController.searchBar.delegate = self
    searchController.searchBar.selectedScopeButtonIndex = UserDefaults.standard.integer(forKey: "selectedindex")

    persistentContiner.loadPersistentStores { (persistentStoreDescription, error) in
        if let error = error {
            print("Unable to Add Persistent Store")
            print("\(error), \(error.localizedDescription)")
        } else {
            self.seed()
        }
    }
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
  }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UserDefaults.standard.set(searchController.searchBar.selectedScopeButtonIndex, forKey: "selectedindex")
    }
  
  func loadSandwiches() {
    let sandwichArray = Bundle.main.decode([SandwichData].self, from: "sandwiches.json")
    sandwiches.append(contentsOf: sandwichArray)
  }

  func saveSandwich(_ sandwich: SandwichData) {
    sandwiches.append(sandwich)
    tableView.reloadData()
  }

  @objc
  func presentAddView(_ sender: Any) {
    performSegue(withIdentifier: "AddSandwichSegue", sender: self)
  }
  
  // MARK: - Search Controller
  var isSearchBarEmpty: Bool {
    return searchController.searchBar.text?.isEmpty ?? true
  }
  
  func filterContentForSearchText(_ searchText: String,
                                  sauceAmount: SauceAmount? = nil) {
    filteredSandwiches = sandwiches.filter { (sandwhich: SandwichData) -> Bool in
      let doesSauceAmountMatch = sauceAmount == .any || sandwhich.sauceAmount == sauceAmount

      if isSearchBarEmpty {
        return doesSauceAmountMatch
      } else {
        return doesSauceAmountMatch && sandwhich.name.lowercased()
          .contains(searchText.lowercased())
      }
    }
    
    tableView.reloadData()
  }
  
  var isFiltering: Bool {
    let searchBarScopeIsFiltering =
      searchController.searchBar.selectedScopeButtonIndex != 0
    return searchController.isActive &&
      (!isSearchBarEmpty || searchBarScopeIsFiltering)
  }
  
  // MARK: - Table View
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return isFiltering ? filteredSandwiches.count : sandwiches.count
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "sandwichCell", for: indexPath) as? SandwichCell
      else { return UITableViewCell() }
    
    let sandwich = isFiltering ?
      filteredSandwiches[indexPath.row] :
      sandwiches[indexPath.row]

    cell.thumbnail.image = UIImage.init(imageLiteralResourceName: sandwich.imageName)
    cell.nameLabel.text = sandwich.name
    cell.sauceLabel.text = sandwich.sauceAmount.description

    return cell
  }
}

// MARK: - UISearchResultsUpdating
extension SandwichViewController: UISearchResultsUpdating {
  func updateSearchResults(for searchController: UISearchController) {
    let searchBar = searchController.searchBar
    let sauceAmount = SauceAmount(rawValue:
      searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex])

    filterContentForSearchText(searchBar.text!, sauceAmount: sauceAmount)
  }
}

// MARK: - UISearchBarDelegate
extension SandwichViewController: UISearchBarDelegate {
  func searchBar(_ searchBar: UISearchBar,
      selectedScopeButtonIndexDidChange selectedScope: Int) {
    UserDefaults.standard.set(searchController.searchBar.selectedScopeButtonIndex, forKey: "selectedindex")
    let sauceAmount = SauceAmount(rawValue:
      searchBar.scopeButtonTitles![selectedScope])
    filterContentForSearchText(searchBar.text!, sauceAmount: sauceAmount)
  }
}



extension SandwichViewController {

    fileprivate func saveFood() {
        guard !UserDefaults.didSeedPersistentStore else {
            return
        }
        do {
            // Save Changes
            print("Saving Changes \(persistentContiner)")
            try persistentContiner.viewContext.save()
            // Update User Defaults
            UserDefaults.setDidSeedPersistentStore(true)
        } catch {
            print("Unable to Save Main Managed Object Context After Seeding Persistent Store (\(error))")
        }
    }

    func seed() {
        var sauceAmountsBuffer: [SauceAmountModel] = []

        for amount in sauceAmounts {
            let sauceAmount = SauceAmountModel(context: persistentContiner.viewContext)
            sauceAmount.sauceAmountString = amount
            sauceAmountsBuffer.append(sauceAmount)
        }

        for data in sandwichArray {
            // Initialize sandwich
            let sandwich = SandwichModel(context: persistentContiner.viewContext)

            // Configure sandwich
            sandwich.name = data.name
            sandwich.imageName = data.imageName
            sandwich.sauceAmount = sauceAmountsBuffer.first {
                return $0.sauceAmountString == data.sauceAmount.rawValue
            }
        }

        saveFood()

    }

    // Mark: - Seed Data
    private var sauceAmounts: [String] {
        return SauceAmount.allCases.map { $0.rawValue }
    }
    private var sandwichArray:[SandwichData] { Bundle.main.decode([SandwichData].self, from: "sandwiches.json")}
}
