//
//  ItemListTableViewController.swift
//  BucketList
//
//  Created by Owen Henley on 7/19/18.
//  Copyright © 2018 Owen Henley. All rights reserved.
//

import UIKit
import CoreData

class ItemListTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ItemController.shared.fetchedResultsController.delegate = self
        //load everythin thats saved to teh view
        ItemController.shared.loadToPersistantStore()
    }
    
    @IBAction func addButtonTapped(_ sender: UIBarButtonItem) {
        // alert controller
        let alertController = UIAlertController(title: "Add an item to your list! 🤩", message: nil, preferredStyle: .alert)
        //add text field to alert controller
        alertController.addTextField { (textField) in
            textField.placeholder = "What do you want to do?..."
        }
        // present the alert controller
        present(alertController, animated: true, completion: nil)
        
        // creat done cancel actions
        let addAction = UIAlertAction(title: "Add", style: .default) { (_) in
            guard let name = alertController.textFields?[0].text else { return } // creat new name, optional, full teh text from teh alert controller text fild, access the first item for the textfirld array, take teh text field text
            ItemController.shared.createNewItem(newName: name) //create new item
            ItemController.shared.loadToPersistantStore() // pull the current info
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
        alertController.addAction(addAction)
        alertController.addAction(cancelAction)
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ItemController.shared.fetchedResultsController.fetchedObjects?.count ?? 0 //
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath) as? ItemTableViewCell else { return UITableViewCell() }
        
        // get the fetched object
        let item = ItemController.shared.fetchedResultsController.object(at: indexPath)
        
        cell.item = item // tell the cell what it wants to populat itself with
        cell.delegate = self
        
        return cell
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let item = ItemController.shared.fetchedResultsController.object(at: indexPath)
            CoreDataStack.managedObjectContext.delete(item)
//            ItemController.shared.deleteItem(item: item)
//            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}

//step 1 - adopt the protocol - MIDDLEMAN -
extension ItemListTableViewController : ItemTableViewCellDelegate {
    
    // step 2 - conform to the protocol
    func toggleItemComplete(cell: ItemTableViewCell) {
        guard let item = cell.item else { return } // grab the item from the cell
        ItemController.shared.toggleItemComplete(for: item)
        cell.updateViews()
    }
    
}

//reload data from alert
// step 1 - ADOPT/Conform
extension ItemListTableViewController : NSFetchedResultsControllerDelegate {
    
    // dont get it??!!
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>,
                    didChange anObject: Any,
                    at indexPath: IndexPath?,
                    for type: NSFetchedResultsChangeType,
                    newIndexPath: IndexPath?) {
        
        switch type { // if teh type is delete, unwrap the index payth and delet from teh table view etc
        case .delete:
            guard let indexPath = indexPath else { return }
            tableView.deleteRows(at: [indexPath], with: .fade)
        case .insert:
            guard let indexPath = newIndexPath else { return }
            tableView.insertRows(at: [indexPath], with: .automatic)
        case .move:
            guard let indexPath = indexPath,
                let newIndexPath = newIndexPath else { return }
            tableView.moveRow(at: indexPath, to: newIndexPath)
        case .update:
            guard let indexPath = indexPath else { return }
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
    }
}
