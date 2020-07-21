//
//  SandwichViewController.swift
//  SandwichSaturation
//
//  Created by Jeff Rames on 7/3/20.
//  Copyright © 2020 Jeff Rames. All rights reserved.
//

import UIKit

protocol SandwichSaveable {
    func saveSandwich(_: SandwichData)
}

class SandwichViewController: UITableViewController, SandwichSaveable {
    let searchController = UISearchController(searchResultsController: nil)
    var sandwiches = [SandwichModel]()
    var filteredSandwiches = [SandwichModel]()
    private let seedingManager = SeedingManager()
    private let coreDataManager = CoreDataManager()

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }



    override func viewDidLoad() {
        super.viewDidLoad()
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(presentAddView(_:)))
        navigationItem.rightBarButtonItem = addButton
        setupSearchController()
        seedingManager.seed()
        self.loadSandwiches()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UserDefaults.standard.set(searchController.searchBar.selectedScopeButtonIndex, forKey: "selectedindex")
    }

    func loadSandwiches() {
        sandwiches.removeAll()
        sandwiches = coreDataManager.getSandwich()
    }

    func saveSandwich(_ sandwich: SandwichData) {
        coreDataManager.saveSandwich(sandwich)
        loadSandwiches()
        tableView.reloadData()
    }

    @objc
    func presentAddView(_ sender: Any) {
        performSegue(withIdentifier: "AddSandwichSegue", sender: self)
    }


    // MARK: - Search Controller

    fileprivate func setupSearchController() {
        // Setup Search Controller
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Filter Sandwiches"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        searchController.searchBar.scopeButtonTitles = SauceAmount.allCases.map { $0.rawValue }
        searchController.searchBar.delegate = self
        searchController.searchBar.selectedScopeButtonIndex = UserDefaults.standard.integer(forKey: "selectedindex")
    }

    var isSearchBarEmpty: Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }

    func filterContentForSearchText(_ searchText: String, sauceAmount: SauceAmount? = nil) {
        filteredSandwiches.removeAll()
        filteredSandwiches = coreDataManager.getFilteredSandwiches(searchText,sauceAmount, isSearchBarEmpty)
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
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isFiltering ? filteredSandwiches.count : sandwiches.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

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
            coreDataManager.deleteSandwich(selectedSandwiche)
            if isFiltering {
                filteredSandwiches.remove(at: indexPath.row)
            }else {
                sandwiches.remove(at: indexPath.row)
            }
            tableView.deleteRows(at: [indexPath], with: .fade)
            coreDataManager.save()
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
