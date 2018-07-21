//
//  ShoppingListTableViewController.swift
//  Shopping List
//
//  Created by Owen Henley on 7/20/18.
//  Copyright © 2018 Owen Henley. All rights reserved.
//

import UIKit
import CoreData

class ShoppingListTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ItemController.shared.fetchedResultsController.delegate = self
        ItemController.shared.loadFromPersistentStore()
    }
    
    @IBAction func addItemTapped(_ sender: UIBarButtonItem) {
        let alertController = UIAlertController(title: "What do you fancy? 🛍", message: nil, preferredStyle: .alert)
        alertController.addTextField { (textField) in
            textField.placeholder = "Add your shopping item..."
        }
        present(alertController, animated: true, completion: nil)
        
        let addAction = UIAlertAction(title: "Add", style: .default) { (_) in
            guard let item = alertController.textFields?[0].text else{ return }
            
            ItemController.shared.newItemWith(newItemName: item)
            ItemController.shared.loadFromPersistentStore()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .default)
        alertController.addAction(addAction)
        alertController.addAction(cancelAction)
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ItemController.shared.fetchedResultsController.fetchedObjects?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "shoppingItemCell", for: indexPath) as? ItemTableViewCell else { return UITableViewCell()}
        
        let item = ItemController.shared.fetchedResultsController.object(at: indexPath)
        
        cell.item = item
        cell.delegate = self
        
        return cell
    }
    
    //xcode 10 & swift 4 change of boiler plate "EditingStyle"
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let item = ItemController.shared.fetchedResultsController.object(at: indexPath)
            CoreDataStack.managedObjectContext.delete(item)
        }
    }
}

extension ShoppingListTableViewController : ItemTableViewCellDelegate {
    func toggleItemComplete(cell: ItemTableViewCell) {
        guard let item = cell.item else { return }
        ItemController.shared.toggleIsComplete(item: item)
        cell.updateViews()
    }
}


extension ShoppingListTableViewController : NSFetchedResultsControllerDelegate {
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch type {
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
