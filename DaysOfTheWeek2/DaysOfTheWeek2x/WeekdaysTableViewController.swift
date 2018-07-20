//
//  WeekdaysTableViewController.swift
//  DaysOfTheWeek2x
//
//  Created by Owen Henley on 7/3/18.
//  Copyright © 2018 Owen Henley. All rights reserved.
//

import UIKit

class WeekdaysTableViewController: UITableViewController {
    
    // Source Of Truth
    let daysOfTheWeek = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return daysOfTheWeek.count
    }
   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dayCell = tableView.dequeueReusableCell(withIdentifier: "dayCell", for: indexPath)
        let day = daysOfTheWeek[indexPath.row]
        print("The indexPath for this day from the days of the week array is \(daysOfTheWeek[indexPath.row])")
        
        let cellNumber = indexPath.row
        
        dayCell.textLabel?.text = day
        dayCell.detailTextLabel?.text = "\(cellNumber+1)"
        
        return dayCell
    }
    
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //check the segue ID
        if segue.identifier == "toDetailVC" {
            //Check destination and index path
            guard let destinationVC = segue.destination as?  DetailViewController, let indexPath = tableView.indexPathForSelectedRow else {return}
            //get the day
            let dayToSend = indexPath.row
            //pass the data
            destinationVC.day = daysOfTheWeek[dayToSend]
        }
       
    }

}
