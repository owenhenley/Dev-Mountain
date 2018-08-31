//
//  NoteDetailViewController.swift
//  NotesV2
//
//  Created by Owen Henley on 7/19/18.
//  Copyright © 2018 Owen Henley. All rights reserved.
//

import UIKit

class NoteDetailViewController: UIViewController {
    
    var note: Note?

    @IBOutlet weak var noteBodyText: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateView()
    }
    
    func updateView() {
        guard let noteToUpdate = note else { return }
        noteBodyText.text = noteToUpdate.bodyText
    }
    
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        guard let noteBodyText = noteBodyText.text else { return }
        
        if let note = note {
            NoteController.shared.editNote(noteToUpdate: note, noteBodyToUpdate: noteBodyText)
        } else {
            NoteController.shared.makeNewNoteWith(newNote: noteBodyText)
        }
        
        navigationController?.popViewController(animated: true)
    }
}
