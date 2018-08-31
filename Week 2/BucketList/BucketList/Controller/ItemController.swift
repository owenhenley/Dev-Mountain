//
//  ItemController.swift
//  BucketList
//
//  Created by Owen Henley on 7/19/18.
//  Copyright © 2018 Owen Henley. All rights reserved.
//

import Foundation
import CoreData

class ItemController {
    
    static var shared = ItemController()
    let fetchedResultsController: NSFetchedResultsController<Item> = {
        //the fect request will be a fetch request for Items,
        let fetchRequst: NSFetchRequest<Item> = Item.fetchRequest()
        // go get the model, and sort it teh way you wnat it seen
        let sort = NSSortDescriptor(key: "isComplete", ascending: false)
        // put the results in an array based on how it comes in
        fetchRequst.sortDescriptors = [sort]
        
        return NSFetchedResultsController(fetchRequest: fetchRequst, managedObjectContext: CoreDataStack.managedObjectContext, sectionNameKeyPath: nil, cacheName: nil) // no sections, so nil, no cache name so nil
    }() // do all this stuff, and use the instructtor () to tell it to use it all
    
    func createNewItem(newName: String) {
        let _ = Item(name: newName)
        saveToPersistanceStore()
    }
    
    func deleteItem(item: Item) {
        item.managedObjectContext?.delete(item)
        saveToPersistanceStore()
    }
    
    func toggleItemComplete(for item: Item) {
        if item.isComplete == true {
            item.isComplete = false
        } else {
            item.isComplete = true
        }
        
        saveToPersistanceStore()
    }
    
    // MARK: - Persistance
    
    func saveToPersistanceStore() {
        do {
            try CoreDataStack.managedObjectContext.save()
        } catch  {
            print("There was an error saving to Core Data: \(error.localizedDescription)")
        }
    }
    
    
    func loadToPersistantStore() {
        do {
            // go get the fetched results
            try fetchedResultsController.performFetch()
        } catch  {
            print("There was an error saving to Core Data: \(error.localizedDescription)")
        }
    }
}

