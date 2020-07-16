//
//  CoreDataManager.swift
//  SandwichSaturation
//
//  Created by Franklin Byaruhanga on 16/07/2020.
//  Copyright © 2020 Jeff Rames. All rights reserved.
//

import CoreData
import UIKit

final class CoreDataManager {

    // MARK: - modelName

    private let modelName: String

    // MARK: - managedObjectContext

    private(set) lazy var managedObjectContext: NSManagedObjectContext = {
        // Initialize Managed Object Context
        let managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)

        // Connect Managed Object Context to  Persistent Store Coordinator
        managedObjectContext.persistentStoreCoordinator = self.persistentStoreCoordinator

        return managedObjectContext
    }()

    // MARK: - managedObjectModel

    private lazy var managedObjectModel: NSManagedObjectModel = {
        // Fetch Model URL
        guard let modelURL = Bundle.main.url(forResource: self.modelName, withExtension: "momd") else {
            fatalError("Unable to Find Data Model")
        }

        // Initialize Managed Object Model
        guard let managedObjectModel = NSManagedObjectModel(contentsOf: modelURL) else {
            fatalError("Unable to Load Data Model")
        }

        return managedObjectModel
    }()

    // MARK: - persistentStoreCoordinator

    private lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        // Initialize Persistent Store Coordinator
        let persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)

        // Helpers
        let fileManager = FileManager.default
        let storeName = "\(self.modelName).sqlite"

        // URL Documents Directory
        let documentsDirectoryURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]

        // URL Persistent Store
        let persistentStoreURL = documentsDirectoryURL.appendingPathComponent(storeName)

        do {
            let options = [NSMigratePersistentStoresAutomaticallyOption:true,
                           NSInferMappingModelAutomaticallyOption:true]
            // Add Persistent Store
            try persistentStoreCoordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: persistentStoreURL, options: options)

        } catch {
            fatalError("Unable to Add Persistent Store")
        }

        return persistentStoreCoordinator
    }()

    // MARK: - Initialization

    init(modelName: String) {
        self.modelName = modelName
        setupNotificationHandling()
    }

    @objc func saveChanges(_ notification: Notification) {
        saveChanges()
    }

    func setupNotificationHandling() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(saveChanges(_:)), name: UIApplication.willTerminateNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(saveChanges(_:)), name: UIApplication.didEnterBackgroundNotification, object: nil)
    }

    private func saveChanges() {
        guard managedObjectContext.hasChanges else { return }
        do {
            try managedObjectContext.save()
        } catch {
            print("Unable to Save Managed Object Context")
            print("\(error), \(error.localizedDescription)")
        }
    }

}


extension NSManagedObjectContext {
    func saveChange() {
        if self.hasChanges {
            do {
                try save()
            } catch {
                print("unable to Save managed Object Context")
                fatalError("Error: \(error.localizedDescription)")
            }
        }
    }
}
