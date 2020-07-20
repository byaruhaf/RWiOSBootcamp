//
//  SauceAmount.swift
//  SandwichSaturation
//
//  Created by Franklin Byaruhanga on 16/07/2020.
//  Copyright © 2020 Jeff Rames. All rights reserved.
//

import Foundation
import CoreData

// Convert Enum to String and String to Enum
extension SauceAmountModel{
    var sauceAmount: SauceAmount {
        get {
            guard let sauceAmountString = self.sauceAmountString,
            let amount = SauceAmount(rawValue: sauceAmountString)
            else { return .none }
            return amount
        }

        set {
            self.sauceAmountString = newValue.rawValue
        }
    }
}

extension SauceAmountModel{
    class func findAll(in managedObjectContext: NSManagedObjectContext) throws -> [SauceAmountModel] {
        // Helpers
        var currentSauceAmounts: [SauceAmountModel] = []

        // Create Fetch Request
        let fetchRequest: NSFetchRequest<SauceAmountModel> = SauceAmountModel.fetchRequest()

        // Perform Fetch Request
        currentSauceAmounts = try managedObjectContext.fetch(fetchRequest)

        return currentSauceAmounts
    }
}
