//
//  LaunchViewController.swift
//  SpaceXAPI
//
//  Created by Owen Henley on 7/24/18.
//  Copyright © 2018 Owen Henley. All rights reserved.
//

import UIKit

class LaunchViewController: UIViewController {
    
    @IBOutlet weak var launchSearchBAr: UISearchBar!
    @IBOutlet weak var flightNumberLabel: UILabel!
    @IBOutlet weak var rocketNameLabel: UILabel!
    @IBOutlet weak var rocketTypeLabel: UILabel!
    @IBOutlet weak var missionBadgeImageView: UIImageView!
    @IBOutlet weak var launchYearLabel: UILabel!
    @IBOutlet weak var launchSiteLabel: UILabel!
    @IBOutlet weak var launchSuccessLabel: UILabel!
    @IBOutlet weak var launchDetailsTextView: UITextView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        launchSearchBAr.delegate = self
    }
}

extension LaunchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text, !searchText.isEmpty else { return }
        
        searchBar.resignFirstResponder()
        
        LaunchController.findLaunch(searchText) { (launch) in
            guard let unwrappedLaunch = launch else { return }
            LaunchController.getMissionBadge(for: unwrappedLaunch, completion: { (image) in
                DispatchQueue.main.async {
                    self.launchSearchBAr.text = ""
                    self.flightNumberLabel.text = "\(unwrappedLaunch.flightNumber)"
                    self.rocketNameLabel.text = unwrappedLaunch.rocket.rocketNameAsString
                    self.rocketTypeLabel.text = unwrappedLaunch.rocket.rocketTypeAsString
                    self.missionBadgeImageView.image = image
                    self.launchYearLabel.text = "\(unwrappedLaunch.launchYearAsString)"
                    self.launchSiteLabel.text = unwrappedLaunch.launchSite.siteNameAsString
                    self.launchSuccessLabel.text = unwrappedLaunch.launchSuccess ? "Successful" : "Unsuccessful"
                    self.launchDetailsTextView.text = unwrappedLaunch.details ?? "None"
                }
            })
        }
    }
}
