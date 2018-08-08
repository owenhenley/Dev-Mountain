//
//  User.swift
//  CloudKitUsers2.0
//
//  Created by Owen Henley on 8/8/18.
//  Copyright © 2018 Owen Henley. All rights reserved.
//

import Foundation
import CloudKit

class User {
	
	let username: String
	let firstName: String
	let lastName: String
	
	var cloudKitRecordID: CKRecord.ID?
	let appleUserReference: CKRecord.Reference
	
	// Keys
	static let userKey = "User"
	fileprivate static let usernameKey = "username"
	fileprivate static let firstNameKey =  "firstName"
	fileprivate static let lastNameKey = "lastName"
	fileprivate static let appleUserReferenceKey = "appleUserReference"
	
	init(username: String, firstName: String, lastName: String, appleUserReference: CKRecord.Reference) {
		self.username = username
		self.firstName = firstName
		self.lastName = lastName
		self.appleUserReference = appleUserReference
	}
	
	//Create a user object out of a CKrecord
	init?(ckRecord: CKRecord) {
		// Unwrap and store the values that are in the record
		guard let username = ckRecord[User.usernameKey] as? String,
		let firstName = ckRecord[User.firstNameKey] as? String,
		let lastName = ckRecord[User.lastNameKey] as? String,
		let appleUserReference = ckRecord[User.appleUserReferenceKey] as? CKRecord.Reference else { return nil }

		//set the values
		self.username = username
		self.firstName = firstName
		self.lastName = lastName
		self.appleUserReference = appleUserReference
		
//		If tracking for update/delete purposes
//		self.cloudKitRecordID = ckRecord.recordID
	}
}

// Creates a record from our user object
extension CKRecord {
	convenience init(user: User) {
		
//		let recordID = user.cloudKitRecordID ?? CKRecord.ID(recordName: UUID().uuidString)
		
		// New instance of CK Record usinf the UUID or User Object
		self.init(recordType: User.userKey)
		
		// Set the vales on the CKRecord to be the same a the objects propertis
		self.setValue(user.username, forKey: User.usernameKey)
		self.setValue(user.firstName, forKey: User.firstNameKey)
		self.setValue(user.lastName, forKey: User.lastNameKey)
		self.setValue(user.appleUserReference, forKey: User.appleUserReferenceKey)
		
		// Assign the UUID or object ID to the User.
//		user.cloudKitRecordID = recordID
	}
}
