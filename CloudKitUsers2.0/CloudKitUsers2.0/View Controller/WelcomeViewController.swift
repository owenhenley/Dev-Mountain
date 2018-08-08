//
//  WelcomeViewController.swift
//  CloudKitUsers2.0
//
//  Created by Owen Henley on 8/8/18.
//  Copyright © 2018 Owen Henley. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {

	@IBOutlet weak var usernameLabel: UILabel!
	
	override func viewDidLoad() {
        super.viewDidLoad()
		
		guard let loggedInUser =  UserController.shared.loggedInUser else { return }
		usernameLabel.text = "\(loggedInUser.firstName)"
    }
}
