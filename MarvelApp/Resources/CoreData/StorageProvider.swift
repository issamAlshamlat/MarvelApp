//
//  StorageProvider.swift
//  MarvelApp
//
//  Created by Issam Abo Alshamlat on 14/09/2022.
//

import Foundation
import CoreData

class StorageProvider {

    static let shared: StorageProvider = .init()

    private let persistentContainer: NSPersistentContainer

    var counter = 0
    
    private init() {
        persistentContainer = .init(name: "MarvelApp")
        persistentContainer.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Core data store failed to load with error: \(error)")
            }
        }
    }
}

extension StorageProvider {
    private func rollBack() {
        DispatchQueue.main.async {
            self.persistentContainer.viewContext.rollback()
        }
    }

    func saveData() throws {
        try self.persistentContainer.viewContext.save()
    }

    func removeFromCoreData(id: Int) {

        let managedcontext = AppDelegate.sharedAppDelegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "OrderFaves")
        let idPredicate: NSPredicate = NSPredicate(format: "id=%@", id)
        fetchRequest.predicate = idPredicate
        let deleterequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        do {
            try managedcontext.execute(deleterequest)
        } catch {
            print(error)
        }
    }
    
    func removeAllItems() {
        let managedcontext = AppDelegate.sharedAppDelegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Car")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        do {
            try managedcontext.execute(deleteRequest)
        } catch let error as NSError {
            // TODO: handle the error
        }
    }
}
