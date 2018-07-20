//
//  NoteListTableViewController.swift
//  NotesV2
//
//  Created by Owen Henley on 7/19/18.
//  Copyright © 2018 Owen Henley. All rights reserved.
//

import UIKit

class NoteListTableViewController: UITableViewController {

    
    @IBAction func addNoteTapped(_ sender: UIBarButtonItem) {
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        NoteController.shared.loadFromPersistentStore()
        tableView.reloadData()
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return NoteController.shared.notes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "noteCell", for: indexPath)
        
        let noteIndex = NoteController.shared.notes[indexPath.row]
        cell.textLabel?.text = noteIndex.bodyText
        
        return cell
    }

   
    // Xcode 10, swift 4.2. New Boiler Plate, will show as error on Xcode 9/4.1
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let noteToBeDeleted = NoteController.shared.notes[indexPath.row]
            NoteController.shared.deleteNote(noteToDelete: noteToBeDeleted)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
   
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toDetailView" {
            guard let index = tableView.indexPathForSelectedRow,
                let destinationVC = segue.destination as? NoteDetailViewController else { return }
            let noteToEdit = NoteController.shared.notes[index.row]
            destinationVC.note = noteToEdit
        }
    }
}
