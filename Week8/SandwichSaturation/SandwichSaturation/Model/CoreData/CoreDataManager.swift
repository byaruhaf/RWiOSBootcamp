//
//  CoreDataManager.swift
//  SandwichSaturation
//
//  Created by Franklin Byaruhanga on 21/07/2020.
//  Copyright © 2020 Jeff Rames. All rights reserved.
//

import UIKit
import CoreData

class CoreDataManager {
    private let appDelegate =  UIApplication.shared.delegate as! AppDelegate
    private let persistentContiner:NSPersistentContainer! = (UIApplication.shared.delegate as! AppDelegate).persistentContainer


    func saveSandwich(_ sandwich: SandwichData) {
        guard persistentContiner != nil else { fatalError("CoreDataManager needs a persistent container.") }
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
        save()
    }

    func deleteSandwich(_ sandwich: SandwichModel) {
        persistentContiner.viewContext.delete(sandwich)
    }

    func favoriteSandwich(_ sandwich: SandwichModel) {
        sandwich.isFavorite = !sandwich.isFavorite
    }

    func hideSandwich(_ sandwich: SandwichModel) {
        sandwich.isVisible = !sandwich.isVisible
    }
    func save() {
        appDelegate.saveContext()
    }

    func getSandwich() -> [[SandwichModel]]{
        var sandwichArray:[SandwichModel]  = []
        do {
            // Fetch current Sauce Amount's
            sandwichArray = try SandwichModel.getSandwichs(in: persistentContiner.viewContext)
        } catch {
            print("Unable to Fetch strored sandwiches, (\(error))")
        }

        let visibleSandwiches = sandwichArray.filter {$0.isVisible}
        let hiddenSandwiches = sandwichArray.filter {$0.isVisible == false}

        return [visibleSandwiches,hiddenSandwiches]
    }

    func getFilteredSandwiches(_ searchText: String,_ sauceAmount: SauceAmount? = nil,_ isSearchBarEmpty: Bool) -> [[SandwichModel]] {
        var filteredSandwiches:[SandwichModel]  = []

        let p0 = NSPredicate(format: "tosauceAmount.sauceAmountString == %@", "\(sauceAmount!.rawValue)")
        let p1 = NSPredicate(format: "name CONTAINS[cd] %@", "\(searchText)")

        var tablePredicate: NSCompoundPredicate {
            if  sauceAmount == .any || isSearchBarEmpty {
                return NSCompoundPredicate(orPredicateWithSubpredicates: [p0,p1])
            } else {
                return NSCompoundPredicate(andPredicateWithSubpredicates: [p0,p1])
            }
        }

        do {
            // Fetch current Sauce Amount's
            filteredSandwiches = try SandwichModel.getSandwichs(in: persistentContiner.viewContext, compoundPredicate: tablePredicate)
        } catch {
            print("Unable to Fetch filtered Sandwiches, (\(error))")
        }

        let visibleSandwiches = filteredSandwiches.filter {$0.isVisible}
        let hiddenSandwiches = filteredSandwiches.filter {$0.isVisible == false}

         return [visibleSandwiches,hiddenSandwiches]
    }



}
