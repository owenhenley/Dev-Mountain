//
//  EntryListTableViewController.swift
//  Journal2.0
//
//  Created by Owen Henley on 7/5/18.
//  Copyright © 2018 Owen Henley. All rights reserved.
//

import UIKit

class EntryListTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        EntryController.shared.loadFromPersistentStore()
    }
    
    override func viewWillAppear(_ animated: Bool) { // reload data before the view arrives. its relaible
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return EntryController.shared.entries.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // create
        let cell = tableView.dequeueReusableCell(withIdentifier: "entryCell", for: indexPath)
        
        // Configure the cell
        // get the entry from the index plath
        let entry = EntryController.shared.entries[indexPath.row]
        
        cell.textLabel?.text = entry.title
        cell.detailTextLabel?.text = "\(entry.timestamp)"
        
        return cell
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let entryToDelete = EntryController.shared.entries[indexPath.row]
            EntryController.shared.delete(entry: entryToDelete)
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    
    
    // MARK: - Navigation
    
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toEntryDetail" {
            
            guard let indexPath = tableView.indexPathForSelectedRow,
                let destinationVC = segue.destination as? DetailViewController
                else { return }
            
            let entryToBePassed = EntryController.shared.entries[indexPath.row]
            destinationVC.entry = entryToBePassed
        }
    }
    
}
