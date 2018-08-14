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
    
//    var planet: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
//        UIImageView.image = UIImage(named: name.lowercased)!
    }
    
    func updateViews() {
        guard let planet = planet, self.isViewLoaded else { return }
        
        title = planet.name
        planetImage.image = UIImage(named: planet.imageName)
        diameter.text = "\(planet.diameter)"
        distanceFromSun.text = "\(planet.millionKMsFromSun)"
        dayLength.text = "\(planet.dayLength)"
    }
    
    var planet: Planet? {
        didSet {
            updateViews()
        }
    }
    
}
