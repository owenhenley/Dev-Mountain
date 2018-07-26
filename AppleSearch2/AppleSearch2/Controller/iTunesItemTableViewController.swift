//
//  iTunesItemTableViewController.swift
//  AppleSearch2
//
//  Created by Owen Henley on 7/26/18.
//  Copyright © 2018 Owen Henley. All rights reserved.
//

import UIKit

class iTunesItemTableViewController: UITableViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return iTunesItemController.shared.iTunesItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "musicCell", for: indexPath) as? iTunesItemTableViewCell else { return UITableViewCell() }
        
        let iTunesItemForCell = iTunesItemController.shared.iTunesItems[indexPath.row]
        
        cell.iTunesItem = iTunesItemForCell
        
        //get image
        iTunesItemController.shared.getImage(for: iTunesItemForCell) { (image) in
            //unwrap image
            guard let image = image else { return }
            cell.iTunesItemAlbumImage = image
        }
        
        return cell
    }
}

extension iTunesItemTableViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text, !searchTerm.isEmpty else { return }
        
        iTunesItemController.shared.getiTunesItems(for: searchTerm) { (success) in
            if success == true {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
            }
        }
        
    }
    
}
