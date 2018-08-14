//
//  WeekDayTableViewController.swift
//  DaysOfTheWeek
//
//  Created by Owen Henley on 7/3/18.
//  Copyright © 2018 Owen Henley. All rights reserved.
//

import UIKit

class WeekDayTableViewController: UITableViewController {
    
    var daysOfTheWeek = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return daysOfTheWeek.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //Create Cell
        let dayCell = tableView.dequeueReusableCell(withIdentifier: "dayCell", for: indexPath)
        
        //Give cell location uing index
        let day = daysOfTheWeek[indexPath.row]
        let cellNumber = indexPath.row
        
        //Add days values to cell labels
        dayCell.textLabel?.text = day
        dayCell.detailTextLabel?.text = "\(cellNumber+1)"
        
        // Configure the cell...
        return dayCell
    }

     //MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // check segue ID
        if segue.identifier == "toDetailVC" {
            // check destination. where is it going?
            guard let destinationVC = segue.destination as? DetailViewController, let indexPath = tableView.indexPathForSelectedRow else { return }
            // get the day
            let day = indexPath.row
            destinationVC.day = daysOfTheWeek[day]
        }
    }
}
