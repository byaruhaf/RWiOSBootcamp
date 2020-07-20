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
        var currentSandwichs: [SandwichModel] = []

        // Create Fetch Request
        let fetchRequest: NSFetchRequest<SandwichModel> = SandwichModel.fetchRequest()

        // Perform Fetch Request
        currentSandwichs = try managedObjectContext.fetch(fetchRequest)

        return currentSandwichs
    }
}
