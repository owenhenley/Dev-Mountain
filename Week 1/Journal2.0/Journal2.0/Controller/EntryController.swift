//
//  EntryController.swift
//  Journal2.0
//
//  Created by Owen Henley on 7/5/18.
//  Copyright © 2018 Owen Henley. All rights reserved.
//

import Foundation

class EntryController {
    // shared instance
    static let shared = EntryController()
    //Source Of Truth
    var entries = [Entry]()
    
    //create
    func addNewEntryWith(title: String, body: String) {
        let newEntry = Entry(title: title, body: body)  //new entry with new title and new body
        entries.append(newEntry) // append the new entry to the
        saveToPersistantStore()
    }
    
    // Update
    func update(entry: Entry, title: String, body: String) { // update the Entry parameters
        entry.title = title
        entry.body = body
        saveToPersistantStore()
    }
    
    // Delete
    func delete(entry: Entry) {
        //find the index
        guard let indexOfEntry = entries.index(of: entry) else { return }
        // remove entry from the entries array
        entries.remove(at: indexOfEntry)
        // guard splits you out of the ficntion. if it doesnt work it kicks you oiut of the function
        saveToPersistantStore()
    }
    
    
    // Persistance
    func fileURL() -> URL {
        
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask) // creatinga folder, so we can go an save stuff there when we need to
        
        let documentDirectory = paths[0] // Acccessing the scomunt directory above, and finsing the index of 0
        
        let journalLocation = "journal.json" // created a string
        
        let url = documentDirectory.appendingPathComponent(journalLocation)
        print(url.absoluteString)
        
        return url
    }
    
    func saveToPersistantStore() {
        // create JSONEncode instance
        let jsonEncoder = JSONEncoder()
        do {
            // turn out entries arry into JSON
            let data = try jsonEncoder.encode(entries)
            try data.write(to: fileURL())
        } catch let error {
            print("There was an error saving to the persistent store: \(error.localizedDescription)")
        }
    }
    
    func loadFromPersistentStore() {
        let jsonDecoder = JSONDecoder()
        do { //create date from file URL
            let data = try Data(contentsOf: fileURL()) // going into fileURL to find the model to decode
            //decode data from JSON to model object
            let entriesFromDecoder = try jsonDecoder.decode([Entry].self, from: data)
            
            // set souces of truth for the entriesd that are decoded
            entries = entriesFromDecoder // when you pull teh decoded entries, this is what you will have if func runs without errors
            
        } catch let error {
            print("There was an error saving to the persistent store: \(error.localizedDescription)")
        }
    }
}


