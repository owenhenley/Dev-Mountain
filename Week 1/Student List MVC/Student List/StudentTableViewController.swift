//
//  StudentTableViewController.swift
//  Student List
//
//  Created by Owen Henley on 7/3/18.
//  Copyright © 2018 Owen Henley. All rights reserved.
//

import UIKit

class StudentTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    let studentController = StudentController()

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.studentController.students.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StudentCell", for: indexPath)
        
        let student = self.studentController.students[indexPath.row]
        cell.textLabel?.text = student.firstName
        
        return cell
    }

    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let tappedIndexPath = tableView.indexPathForSelectedRow else { return }
        
        let student = self.studentController.students[tappedIndexPath.row]
        if let detailVC = segue.destination as? StudentDetailViewController {
            detailVC.student = student
        }
    }
    
}
