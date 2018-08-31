//
//  DetailViewController.swift
//  Journal2.0
//
//  Created by Owen Henley on 7/5/18.
//  Copyright © 2018 Owen Henley. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var entry: Entry? // ready to catch the information
    
    //Outlets
    @IBOutlet weak var entryTitleTextField: UITextField!
    @IBOutlet weak var entryBodyTextView: UITextView!
    
    // Actions
    @IBAction func saveBarButton(_ sender: UIBarButtonItem) { //remeber to say tapped
        guard let entryTitle = entryTitleTextField.text, !entryTitle.isEmpty, // unwrap the entrytitletextfield so see of its empty, if its NOT empty, keep going
            let entryBody = entryBodyTextView.text, !entryBody.isEmpty
            else { return }
        
        if let unwrappedEntry = entry{ //new entry, not guard,we want to stay in the function
            EntryController.shared.update(entry: unwrappedEntry, title: entryTitle, body: entryBody)
        } else {
            EntryController.shared.addNewEntryWith(title: entryTitle, body: entryBody)
        }
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func clearEntryButton(_ sender: UIButton) { // say tapped! its an action
        entryBodyTextView.text = ""
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    // update the entry if text Outlets are
    func updateViews() {
        guard let unwrappedEntry = entry else { return }  // check if entry is not nil
        title = unwrappedEntry.title // "\(unwrappedEntry.timestamp)"
        entryTitleTextField.text = unwrappedEntry.title // change the text outlets if tapped on the save button
        entryBodyTextView.text = unwrappedEntry.body
    }
    
}
