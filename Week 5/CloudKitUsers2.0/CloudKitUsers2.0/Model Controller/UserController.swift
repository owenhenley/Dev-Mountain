//
//  UserController.swift
//  CloudKitUsers2.0
//
//  Created by Owen Henley on 8/8/18.
//  Copyright © 2018 Owen Henley. All rights reserved.
//

import Foundation
import CloudKit

class UserController {
	
	static let shared = UserController()
	
	var loggedInUser: User?
	
	

	// MARK: - CRUD
	
	// New User
	func createNewUserWith(username: String, firstName: String, lastName: String, completion: @escaping (Bool) -> Void) {
		
		// Grab the unique ID from the user
		CKContainer.default().fetchUserRecordID { (appleUserRecordID, error) in
			if let error = error {
				print("Couldnt obtian user from cloud: \(error.localizedDescription)")
				completion(false)
				return
			}
			guard let appleUserRecordID = appleUserRecordID else { completion(false) ; return}
			
			// Create our anchor to the "Users" record
			let appleUserReference = CKRecord.Reference(recordID: appleUserRecordID, action: .deleteSelf)
			
			let newUser = User(username: username, firstName: firstName, lastName: lastName, appleUserReference: appleUserReference)
			
			let newUserRecord = CKRecord(user: newUser)
			
			CKContainer.default().publicCloudDatabase.save(newUserRecord, completionHandler: { (_, error) in
				if let error = error {
					print("error: \(error.localizedDescription)")
					completion(false)
					return
				}
				
				self.loggedInUser = newUser
				completion(true)
			})
		}
		
	}
	
	// Fetch User
	func fetchCurrentUser(completion: @escaping (Bool) -> Void) {
		// get record ID
		CKContainer.default().fetchUserRecordID { (appleUserRecordID, error) in
			if let error = error {
				print("error: \(error.localizedDescription)")
				completion(false)
				return
			}
			guard let appleUserRecordID = appleUserRecordID else { completion(false) ; return }
			
			let predicate = NSPredicate(format: "appleUserReference == %@", appleUserRecordID)
			
			let query = CKQuery(recordType: User.userKey, predicate: predicate)
			
			CKContainer.default().publicCloudDatabase.perform(query, inZoneWith: nil, completionHandler: { (records, error) in
				if let error = error {
					print("error: \(error.localizedDescription)")
					completion(false)
					return
				}
				guard let records = records else { completion(false) ; return }
				
				guard let userRecord = records.first else { completion(false) ; return}
				let loggedInUser = User(ckRecord: userRecord)
				self.loggedInUser = loggedInUser
				
//				self.loggedInUser = User(ckRecord: records[0])
				completion(true)
			})
		}
	}
	
}
