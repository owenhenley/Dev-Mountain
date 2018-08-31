//
//  SecondLoadScreenViewController.swift
//  CloudKitUsers2.0
//
//  Created by Owen Henley on 8/8/18.
//  Copyright © 2018 Owen Henley. All rights reserved.
//

import UIKit

class SecondLoadScreenViewController: UIViewController {
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		UserController.shared.fetchCurrentUser { (success) in
			if success {
				DispatchQueue.main.async {
					// Send them to Welcome Screen
					let storyboard = UIStoryboard(name: "Main", bundle: nil)
					let welcomeVC = storyboard.instantiateViewController(withIdentifier: "WelcomeVC")
					self.present(welcomeVC, animated: true, completion: nil)
				}
				
			} else {
				DispatchQueue.main.async {
					// Send to New User Screen
					let storyboard = UIStoryboard(name: "Main", bundle: nil)
					let signUpVC = storyboard.instantiateViewController(withIdentifier: "SignUpVC")
					self.present(signUpVC, animated: true, completion: nil)
				}
			}
		}
	}
}
