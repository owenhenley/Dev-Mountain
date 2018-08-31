//
//  PlanetDetailViewController.swift
//  SolarSystem
//
//  Created by Owen Henley on 7/3/18.
//  Copyright © 2018 Owen Henley. All rights reserved.
//

import UIKit

class PlanetDetailViewController: UIViewController {
    
    @IBOutlet weak var planetImage: UIImageView!
    @IBOutlet weak var distanceFromSun: UILabel!
    @IBOutlet weak var dayLength: UILabel!
    @IBOutlet weak var diameter: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    func updateViews() {
        guard let planet = planet, self.isViewLoaded else { return }
        
        title = planet.name
        planetImage.image = UIImage(named: planet.imageName)
        diameter.text = "\(planet.diameter) Kilometers"
        distanceFromSun.text = "\(planet.millionKMsFromSun) Kilometers"
        dayLength.text = "\(planet.dayLength) Hours"
    }
    
    var planet: Planet? {
        didSet {
            updateViews()
        }
    }
}
