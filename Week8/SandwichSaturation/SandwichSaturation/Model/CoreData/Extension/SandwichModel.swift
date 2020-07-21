//
//  SandwichModel.swift
//  SandwichSaturation
//
//  Created by Franklin Byaruhanga on 20/07/2020.
//  Copyright © 2020 Jeff Rames. All rights reserved.
//

import Foundation
import CoreData

extension SandwichModel{
    class func getSandwichs(in managedObjectContext: NSManagedObjectContext,  compoundPredicate: NSCompoundPredicate? = nil) throws -> [SandwichModel] {
        // Helpers
        var allSandwichs: [SandwichModel] = []

        // Create Fetch Request
        let fetchRequest: NSFetchRequest<SandwichModel> = SandwichModel.fetchRequest()

        // Add sort Descriptors
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true, selector: #selector(NSString.caseInsensitiveCompare))]

         // Add Predicate's
        if let compoundPredicate = compoundPredicate {
            fetchRequest.predicate = compoundPredicate
        }

        // Perform Fetch Request
        allSandwichs = try managedObjectContext.fetch(fetchRequest)

        return allSandwichs
    }
}
