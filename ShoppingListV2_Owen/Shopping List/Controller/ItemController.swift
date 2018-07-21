//
//  ItemController.swift
//  Shopping List
//
//  Created by Owen Henley on 7/20/18.
//  Copyright © 2018 Owen Henley. All rights reserved.
//

import Foundation
import CoreData

class ItemController {
    
    static var shared = ItemController()

    let fetchedResultsController: NSFetchedResultsController<Item> = {
        
        let fetchRequest: NSFetchRequest<Item> = Item.fetchRequest()
        let sort = NSSortDescriptor(key: "isComplete", ascending: false)
        fetchRequest.sortDescriptors = [sort]
        
        return NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataStack.managedObjectContext,
                                          sectionNameKeyPath: nil, cacheName: nil)
    }()
    
    func newItemWith(newItemName: String) {
        let _ = Item(name: newItemName)
        saveToPersistantStore()
    }
    
    func deleteFromList(item: Item) {
        item.managedObjectContext?.delete(item)
        saveToPersistantStore()
    }
    
    func toggleIsComplete(item: Item) {
        if item.isComplete == true {
            item.isComplete = false
        } else {
            item.isComplete = true
        }
        saveToPersistantStore()
    }
    
    // MARK: - Persistance
    
    func saveToPersistantStore() {
        do {
            try CoreDataStack.managedObjectContext.save()
        } catch {
            print("There was an error saving to CoreData: \(error.localizedDescription)")
        }
    }
    
    func loadFromPersistentStore() {
        do {
           try fetchedResultsController.performFetch()
        } catch {
            print("There was an error loading from CoreData: \(error.localizedDescription)")
        }
    }
    
}
