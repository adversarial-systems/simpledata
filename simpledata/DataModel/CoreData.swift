//
//  CoreData.swift
//  simpledata
//
//  Created by user on 9/20/20.
//

import CoreData

public class PersistentCloudKitContainer {
    // MARK: - Define Constants / Variables
    public static var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    // MARK: - Initializer
    private init() {}
    // MARK: - Core Data stack
    public static var persistentContainer: NSPersistentContainer = {
        // using "New File..." from the Project Navigator, must have created a CoreData -- "Data Model" of same name e.g. simpledata.xcdatamodeld
        let container = NSPersistentContainer(name: "simpledata")
        
        // Set location, via NSPersistentStoreDescription, for CoreData storage in local filesystem
        // THIS SECTION CAN BE COMMENTED OUT BUT BE AWARE, YOU MUST USE THE URL OPTION IF YOU INTEND TO USE THIS FEATURE
        // Failing to set the url for the description causes it to point to /dev/null which is bad.
        let storeDirectory = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).first!
        let url = storeDirectory.appendingPathComponent("simpledata.sqlite")
        let description = NSPersistentStoreDescription(url: url)
        description.shouldMigrateStoreAutomatically = true
        description.shouldInferMappingModelAutomatically = true
        description.shouldAddStoreAsynchronously = false
        container.persistentStoreDescriptions =  [description]
        // END Set Location of CoreData storage
      
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
          
          // This if statement can also be commented out
          // It is used to help locate the coredata storage file in the local filesystem
          // really only useful for debugging
          if let storeDescription = storeDescription as NSPersistentStoreDescription? {
            print("CoreData Store fileType: \(storeDescription.type)")
            print("CoreData Store url: \(storeDescription.url!)")
            
            print("Add Store Async? \(storeDescription.shouldAddStoreAsynchronously)")
            print("Migrate Store Auto? \(storeDescription.shouldMigrateStoreAutomatically)")
            print("Infer Mapping Model Auto? \(storeDescription.shouldInferMappingModelAutomatically)")
            print("--------- Datastore Config Review Complete ------------")
          }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        
        return container
    }()
    // MARK: - Core Data Saving support
    public static func saveContext () {
        let context = persistentContainer.viewContext
      
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
