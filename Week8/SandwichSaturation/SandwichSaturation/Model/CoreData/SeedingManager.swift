//
//  SeedingManager.swift
//  SandwichSaturation
//
//  Created by Franklin Byaruhanga on 21/07/2020.
//  Copyright © 2020 Jeff Rames. All rights reserved.
//

import UIKit
import CoreData

class SeedingManager {
    private let appDelegate =  UIApplication.shared.delegate as! AppDelegate
    private let persistentContiner:NSPersistentContainer! = (UIApplication.shared.delegate as! AppDelegate).persistentContainer

    func seed() {
        guard persistentContiner != nil else { fatalError("SeedingManager needs a persistent container.") }
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
