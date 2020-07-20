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
    class func findAll(in managedObjectContext: NSManagedObjectContext) throws -> [SandwichModel] {
        // Helpers
        var allSandwichs: [SandwichModel] = []

        // Create Fetch Request
        let fetchRequest: NSFetchRequest<SandwichModel> = SandwichModel.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: #keyPath(SandwichModel.name), ascending: false)]

        // Perform Fetch Request
        allSandwichs = try managedObjectContext.fetch(fetchRequest)

        return allSandwichs
    }

    class func findFilterd(in managedObjectContext: NSManagedObjectContext, compoundPredicate: NSCompoundPredicate) throws -> [SandwichModel] {
        // Helpers
        var allSandwichs: [SandwichModel] = []

        // Create Fetch Request
        let fetchRequest: NSFetchRequest<SandwichModel> = SandwichModel.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: #keyPath(SandwichModel.name), ascending: false)]
        fetchRequest.predicate = compoundPredicate
        

        // Perform Fetch Request
        allSandwichs = try managedObjectContext.fetch(fetchRequest)

        return allSandwichs
    }

}
