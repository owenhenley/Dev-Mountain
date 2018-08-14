//
//  PlanetTableViewController.swift
//  SolarSystem
//
//  Created by Owen Henley on 7/3/18.
//  Copyright © 2018 Owen Henley. All rights reserved.
//

import UIKit

class PlanetTableViewController: UITableViewController {
	
	let planetsList = ["Mercury", "Venus", "Earth", "Mars", "Jupiter", "Saturn", "Uranus", "Neptune", "Pluto"]
	
	override func viewDidLoad() {
		super.viewDidLoad()
	}
	
	// MARK: - Table view data source
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return PlanetController.planets.count
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		//create cell
		let planetCell = tableView.dequeueReusableCell(withIdentifier: "planetCell", for: indexPath)
		
		// give cell location
		let planet = PlanetController.planets[indexPath.row]
		
		//add planet value to cell label
		planetCell.textLabel?.text = planet.name
		
		// configure cell
		return planetCell
	}
	
	// MARK: - Navigation
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		
		// check segue ID
		if segue.identifier == "toPlanetDetailVC" {
			//where is it going?
			if let destinationVC = segue.destination as? PlanetDetailViewController,
				let index = (self.tableView.indexPathForSelectedRow as NSIndexPath?)?.row {
				
				let planet = PlanetController.planets[index]
				destinationVC.planet = planet
			}
		}
		
	}
	
	
}
