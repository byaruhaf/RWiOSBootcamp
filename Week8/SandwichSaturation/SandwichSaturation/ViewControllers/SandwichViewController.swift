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

    // MARK: - Segues

    private enum Segue {

        static let AddSandwich = "AddSandwichSegue"
        static let DetailSandwich = "DetailSandwichSegue"

    }


    let searchController = UISearchController(searchResultsController: nil)
    var sandwiches = [[SandwichModel]]()
    var filteredSandwiches = [[SandwichModel]]()
    private let seedingManager = SeedingManager()
    private let coreDataManager = CoreDataManager()
    private var detailindexPath:IndexPath? = nil

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
        if isFiltering {
            updateSearchResults(for: searchController)
        }else {
        sandwiches.removeAll()
        sandwiches = coreDataManager.getSandwich()
        }
    }

    func saveSandwich(_ sandwich: SandwichData) {
        coreDataManager.saveSandwich(sandwich)
        loadSandwiches()
        tableView.reloadData()
    }

    @objc
    func presentAddView(_ sender: Any) {
        performSegue(withIdentifier: Segue.AddSandwich, sender: self)
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
    var headerTitles:[String] { ["Visible Sandwiches", "Hidden Sandwiches"] }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return isFiltering ? filteredSandwiches.count : sandwiches.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isFiltering ? filteredSandwiches[section].count : sandwiches[section].count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: "sandwichCell", for: indexPath) as? SandwichCell
            else { return UITableViewCell() }
        let sandwich = isFiltering ? filteredSandwiches[indexPath.section][indexPath.row] : sandwiches[indexPath.section][indexPath.row]
        cell.thumbnail.image = UIImage.init(imageLiteralResourceName: sandwich.imageName!)
        cell.nameLabel.text = sandwich.name
        cell.sauceLabel.text = sandwich.tosauceAmount?.sauceAmount.rawValue

            cell.favImage.image = UIImage(systemName: "suit.heart.fill", withConfiguration: UIImage.SymbolConfiguration(weight: .regular))?.withTintColor(.systemPink, renderingMode: .alwaysOriginal)
         if sandwich.isFavorite {
            cell.favImage.isHidden = false

        }else {
             cell.favImage.isHidden = true
        }
        return cell
    }

//    titleForHeaderInSection
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section < headerTitles.count {
            return headerTitles[section]
        }
        return nil
    }

    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let favAction = UIContextualAction(style: .normal, title: "") {  [weak self] (action, view, nil) in
            let selectedSandwiche = self!.isFiltering ? self?.filteredSandwiches[indexPath.section][indexPath.row] : self?.sandwiches[indexPath.section][indexPath.row]
            self?.coreDataManager.favoriteSandwich(selectedSandwiche!)
            self?.coreDataManager.save()
            tableView.reloadData()
        }
        let moreAction = UIContextualAction(style: .normal, title: "...") { [weak self] (action, view, nil) in
            self?.detailindexPath = indexPath
            self?.performSegue(withIdentifier: Segue.DetailSandwich, sender: nil)
        }
        favAction.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        moreAction.backgroundColor = #colorLiteral(red: 0.9369273186, green: 1, blue: 0.9328868985, alpha: 1)
        favAction.image = UIImage(systemName: "heart.fill", withConfiguration: UIImage.SymbolConfiguration(weight: .regular))?.withTintColor(.systemPink, renderingMode: .alwaysOriginal)
        moreAction.image = UIImage(systemName: "ellipsis", withConfiguration: UIImage.SymbolConfiguration(weight: .regular))?.withTintColor(.systemBlue, renderingMode: .alwaysOriginal)
        let config = UISwipeActionsConfiguration(actions: [moreAction,favAction])
//        config.performsFirstActionWithFullSwipe = false
        return config
    }

    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "Delete") {  [weak self] (action, view, nil) in
            let selectedSandwiche = self!.isFiltering ? self?.filteredSandwiches[indexPath.section][indexPath.row] : self?.sandwiches[indexPath.section][indexPath.row]
            self?.coreDataManager.deleteSandwich(selectedSandwiche!)
            if self!.isFiltering {
                self?.filteredSandwiches[indexPath.section].remove(at: indexPath.row)
            }else {
                self?.sandwiches[indexPath.section].remove(at: indexPath.row)
            }
            tableView.deleteRows(at: [indexPath], with: .fade)
            self?.coreDataManager.save()
            tableView.reloadData()
        }
        let hidden = UIContextualAction(style: .normal, title: "Hidden") {  [weak self] (action, view, nil) in
            let selectedSandwiche = self!.isFiltering ? self?.filteredSandwiches[indexPath.section][indexPath.row] : self?.sandwiches[indexPath.section][indexPath.row]
            self?.coreDataManager.hideSandwich(selectedSandwiche!)
            self?.coreDataManager.save()
            self?.loadSandwiches()

            DispatchQueue.main.async {
                if tableView.numberOfSections > 1 {
                    self?.tableView.reloadSections([0,1], with: .top)
                } else {
                    tableView.reloadData()
                }
            }
        }
        delete.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        hidden.backgroundColor = #colorLiteral(red: 0.9375473857, green: 0.9991515279, blue: 0.9319750667, alpha: 1)
        hidden.image = UIImage(systemName: "eye", withConfiguration: UIImage.SymbolConfiguration(weight: .regular))?.withTintColor(.systemIndigo, renderingMode: .alwaysOriginal)
        delete.image = UIImage(systemName: "trash.fill", withConfiguration: UIImage.SymbolConfiguration(weight: .regular))?.withTintColor(.systemRed, renderingMode: .alwaysOriginal)
        let config = UISwipeActionsConfiguration(actions: [delete,hidden])
         config.performsFirstActionWithFullSwipe = false
        return config
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        guard let identifier = segue.identifier else { return }

        switch identifier {
            case Segue.DetailSandwich:
                guard let destination = segue.destination as? DetailSandwichViewController else { return }
                guard let indexPath =  detailindexPath else { return }
            let sandwich = isFiltering ? filteredSandwiches[indexPath.section][indexPath.row] : sandwiches[indexPath.section][indexPath.row]
                // Configure Destination
                destination.sandwich = sandwich
            default:
                break
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
