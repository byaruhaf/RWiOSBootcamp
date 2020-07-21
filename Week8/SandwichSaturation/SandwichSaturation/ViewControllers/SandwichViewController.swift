//
//  SandwichViewController.swift
//  SandwichSaturation
//
//  Created by Jeff Rames on 7/3/20.
//  Copyright © 2020 Jeff Rames. All rights reserved.
//

import UIKit
import CoreData

protocol SandwichSaveable {
    func saveSandwich(_: SandwichData)
}

class SandwichViewController: UITableViewController, SandwichSaveable {
    let searchController = UISearchController(searchResultsController: nil)
    var sandwiches = [SandwichModel]()
    var filteredSandwiches = [SandwichModel]()
    private let appDelegate =  UIApplication.shared.delegate as! AppDelegate
    private let persistentContiner:NSPersistentContainer! = (UIApplication.shared.delegate as! AppDelegate).persistentContainer

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        guard persistentContiner != nil else { fatalError("This view needs a persistent container.") }
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(presentAddView(_:)))
        navigationItem.rightBarButtonItem = addButton

//        let editButton = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(deleteItems(_:)))
//        navigationItem.leftBarButtonItem = editButton
        self.navigationItem.leftBarButtonItem = self.editButtonItem

        // Setup Search Controller
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Filter Sandwiches"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        searchController.searchBar.scopeButtonTitles = SauceAmount.allCases.map { $0.rawValue }
        searchController.searchBar.delegate = self
        searchController.searchBar.selectedScopeButtonIndex = UserDefaults.standard.integer(forKey: "selectedindex")
        self.seed()
        self.loadSandwiches()
    }

    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: true)
        tableView.setEditing(tableView.isEditing, animated: true)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UserDefaults.standard.set(searchController.searchBar.selectedScopeButtonIndex, forKey: "selectedindex")
    }

    func loadSandwiches() {
        sandwiches.removeAll()
        do {
            // Fetch current Sauce Amount's
            let sandwichArray = try SandwichModel.getSandwichs(in: persistentContiner.viewContext)
            sandwiches.append(contentsOf: sandwichArray)
        } catch {
            print("Unable to Fetch strored sandwiches, (\(error))")
        }
    }

    func saveSandwich(_ sandwich: SandwichData) {
        let newSandwich = SandwichModel(context: persistentContiner.viewContext)
        // Configure sandwich
        newSandwich.name = sandwich.name
        newSandwich.imageName = sandwich.imageName

        do {
            // Fetch current Sauce Amount's
            let currentSauceAmounts = try SauceAmountModel.findAll(in: persistentContiner.viewContext)
            newSandwich.tosauceAmount = currentSauceAmounts.first {
                $0.sauceAmountString == sandwich.sauceAmount.rawValue
            }
        } catch {
            print("Unable to Fetch current Sauce Amounts, (\(error))")
        }
        appDelegate.saveContext()
        loadSandwiches()
        tableView.reloadData()
    }

    @objc
    func presentAddView(_ sender: Any) {
        performSegue(withIdentifier: "AddSandwichSegue", sender: self)
    }
    @objc
    func deleteItems(_ sender: Any) {
//        if let selectedRows = tableView.indexPathsForSelectedRows {
//            let items = selectedRows.map() {
//                mytodos.todos[$0.row]
//            }
//            mytodos.remove(items: items)
//            tableView.reloadData()
//        }
    }

    // MARK: - Search Controller
    var isSearchBarEmpty: Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }

    func filterContentForSearchText(_ searchText: String, sauceAmount: SauceAmount? = nil) {
        let p0 = NSPredicate(format: "tosauceAmount.sauceAmountString == %@", "\(sauceAmount!.rawValue)")
        let p1 = NSPredicate(format: "name CONTAINS[cd] %@", "\(searchText)")

        var tablePredicate: NSCompoundPredicate {
            if  sauceAmount == .any || isSearchBarEmpty {
                return NSCompoundPredicate(orPredicateWithSubpredicates: [p0,p1])
            } else {
                return NSCompoundPredicate(andPredicateWithSubpredicates: [p0,p1])
            }
        }

        filteredSandwiches.removeAll()
        do {
            // Fetch current Sauce Amount's
            let sandwichArray = try SandwichModel.getSandwichs(in: persistentContiner.viewContext, compoundPredicate: tablePredicate)
            filteredSandwiches.append(contentsOf: sandwichArray)
        } catch {
            print("Unable to Fetch filtered Sandwiches, (\(error))")
        }
        tableView.reloadData()
    }

    var isFiltering: Bool {
        let searchBarScopeIsFiltering =
            searchController.searchBar.selectedScopeButtonIndex != 0
        return searchController.isActive &&
            (!isSearchBarEmpty || searchBarScopeIsFiltering)
    }



}

// MARK: - TableView Setup
extension SandwichViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        //        guard let sections = fetchedResultsController.sections else { return 0}
        //        return sections.count
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isFiltering ? filteredSandwiches.count : sandwiches.count
        //        guard let section = fetchedResultsController.sections?[section] else { return 0}
        //        return section.numberOfObjects
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        // Dequeue Reusable Cell
        //        guard let cell = tableView.dequeueReusableCell(withIdentifier: "sandwichCell", for: indexPath) as? SandwichCell else {
        //            fatalError("Unexpected Index Path")
        //        }

        //        let sandwich = fetchedResultsController.object(at: indexPath)



        guard let cell = tableView.dequeueReusableCell(withIdentifier: "sandwichCell", for: indexPath) as? SandwichCell
            else { return UITableViewCell() }
        let sandwich = isFiltering ? filteredSandwiches[indexPath.row] : sandwiches[indexPath.row]
        cell.thumbnail.image = UIImage.init(imageLiteralResourceName: sandwich.imageName!)
        cell.nameLabel.text = sandwich.name
        cell.sauceLabel.text = sandwich.tosauceAmount?.sauceAmount.rawValue
        return cell
    }
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        true
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let selectedSandwiche = isFiltering ? filteredSandwiches[indexPath.row] : sandwiches[indexPath.row]
            persistentContiner.viewContext.delete(selectedSandwiche)
            if isFiltering {
                filteredSandwiches.remove(at: indexPath.row)
            }else {
                sandwiches.remove(at: indexPath.row)
            }
            tableView.deleteRows(at: [indexPath], with: .fade)

            appDelegate.saveContext()
            tableView.reloadData()
        }
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


// MARK: - Seeding the CoreData Model
extension SandwichViewController {
    func seed() {
        guard !UserDefaults.didSeedPersistentStore else { return }
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
            sandwich.tosauceAmount = sauceAmountsBuffer.first {
                return $0.sauceAmountString == data.sauceAmount.rawValue
            }
        }
        appDelegate.saveContext()
        // Update User Defaults
        UserDefaults.setDidSeedPersistentStore(true)
    }

    // Mark: - Seed Data
    //Enum Data
    private var sauceAmounts: [String] {
        return SauceAmount.allCases.map { $0.rawValue }
    }
    //JSON Data
    private var sandwichArray:[SandwichData] { Bundle.main.decode([SandwichData].self, from: "sandwiches.json")}
}

// MARK: - Fetched Results Controller setup
extension SandwichViewController {

    // MARK: -

    //    private lazy var fetchedResultsController:NSFetchedResultsController<SandwichModel>  = {
    //        // Create Fetch Request
    //        let fetchRequest: NSFetchRequest<SandwichModel> = SandwichModel.fetchRequest()
    //
    //        // Configure Fetch Request
    //        fetchRequest.sortDescriptors = [NSSortDescriptor(key: #keyPath(SandwichModel.name), ascending: false)]
    //
    //        // Create Fetched Results Controller
    //        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.persistentContiner.viewContext, sectionNameKeyPath: nil, cacheName: nil)
    //
    //        // Configure Fetched Results Controller
    //        fetchedResultsController.delegate = self
    //
    //        return fetchedResultsController
    //    }()

    // MARK: -

    //    private var hasSandwichs: Bool {
    //        guard let fetchedObjects = fetchedResultsController.fetchedObjects else { return false }
    //        return fetchedObjects.count > 0
    //    }


    //    func fetchSandwiches() {
    //        do {
    //            try fetchedResultsController.performFetch()
    //        } catch {
    //            print("Unable to Persorm Fetch Reests")
    //            print("\(error),\(error.localizedDescription)")
    //        }
    //    }

}
