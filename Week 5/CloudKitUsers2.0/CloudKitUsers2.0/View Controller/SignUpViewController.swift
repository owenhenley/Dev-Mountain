//
//  SignUpViewController.swift
//  CloudKitUsers2.0
//
//  Created by Owen Henley on 8/8/18.
//  Copyright © 2018 Owen Henley. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
	
	@IBOutlet weak var usernameTextField: UITextField!
	@IBOutlet weak var firstNameTextField: UITextField!
	@IBOutlet weak var lastNameTextField: UITextField!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
	}
	
	@IBAction func signUpTapped(_ sender: Any) {
		guard let username = usernameTextField.text, !username.isEmpty,
			let firstName = firstNameTextField.text, !firstName.isEmpty,
			let lastName = lastNameTextField.text,!lastName.isEmpty else { return }
		
		UserController.shared.createNewUserWith(username: username, firstName: firstName, lastName: lastName) { (success) in
			if success {
				DispatchQueue.main.async {
					self.performSegue(withIdentifier: "toWelcomeVC", sender: self)
				}
			}
		}
		
	}
}
