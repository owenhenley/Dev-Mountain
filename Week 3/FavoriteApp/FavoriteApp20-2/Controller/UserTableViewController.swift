//
//  UserTableViewController.swift
//  FavoriteApp20-2
//
//  Created by Owen Henley on 7/25/18.
//  Copyright © 2018 Frank Martin Jr. All rights reserved.
//

import UIKit

class UserTableViewController: UITableViewController {
    
    var users: [User] = []
    
    @IBAction func newUserTapped(_ sender: UIBarButtonItem) {
        
        let alertController = UIAlertController(title: "Add a new user 😎", message: nil, preferredStyle: .alert)
        alertController.addTextField { (nameTextField) in
            nameTextField.placeholder = "Enter Name Here"
        }
        alertController.addTextField(configurationHandler: { (favAppTextField) in
            favAppTextField.placeholder = "Enter Fave App Here"
        })
        
        let submitAction = UIAlertAction(title: "Submit", style: .default) { (_) in
            // this is what happens when teh submit button i tapped
            let name = alertController.textFields?[0].text
            let favApp = alertController.textFields?[1].text
            UserController.postNewUser(name: name!, favApp: favApp!, completion: { (user) in
                guard let unwrappedUser = user else { return }
                self.users.append(unwrappedUser)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            })
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
        
        alertController.addAction(submitAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
    
    
    
    //2 text views
    //2 buton cancel/add
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UserController.getUsers { (users) in
            guard let unwrappedUsers = users else { return }
            self.users = unwrappedUsers
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath)
        
        let user = users[indexPath.row]
        cell.textLabel?.text = user.name
        cell.detailTextLabel?.text = user.favApp
        
        return cell
    }
}

