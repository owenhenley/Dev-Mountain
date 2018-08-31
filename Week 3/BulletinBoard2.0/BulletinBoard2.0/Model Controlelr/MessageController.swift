//
//  MessageController.swift
//  BulletinBoard2.0
//
//  Created by Owen Henley on 8/6/18.
//  Copyright © 2018 Owen Henley. All rights reserved.
//

import Foundation
import CloudKit

class MessageController {
	
	static let shared = MessageController()
	
	//SOT
	var messages: [Message] = []
	
	// Access the public database with a reference
	let publicDB = CKContainer.default().publicCloudDatabase
	
	// New Message
	func postNewMessage(with messageText: String, completion: @escaping (Bool) -> Void) {
		
		// Create CKrecord  new message
		let newMessage = Message(messageText: messageText)
		
		let messageAsRecord = CKRecord(message: newMessage)
		
		publicDB.save(messageAsRecord) { (_, error) in
			if let error = error {
				print("Error saving message to iCloud: \(error.localizedDescription)")
				completion(false)
				return
			} else {
				
				// Keep our local messages array in sync with our database
				self.messages.append(newMessage)
				completion(true)
			}
		}
	}
	
	// Get Messages
	func fetchAllMessagesFromCloud(completion: @escaping (Bool) -> Void) {
		
		// Give me everything if value is true (filter)
		let predicate = NSPredicate(value: true)
		
		//what we want
		let query = CKQuery(recordType: Message.messageTypeKey, predicate: predicate)
		
		publicDB.perform(query, inZoneWith: nil) { (records, error) in
			if let error = error {
				print("There was an error fetching messages from cloud: \(error.localizedDescription)")
				completion(false)
				return }
			// Unwrap pulled records
			
			guard let records = records else { completion(false) ; return }
			let messages = records.compactMap { Message(ckRecord: $0) }
			
			// Long Hand ->
			//				let messages2 = records.compactMap({ (record) -> Message? in
			//					let message = Message(ckRecord: record)
			//					return message
			//				})
			
			// Burte Force ->
			//				var messages3: [Message] = []
			//				for record in records {
			//					let message = Message(ckRecord: record)
			//					messages3.append(message)
			//				}
			
			self.messages = messages
			completion(true)
		}
		
	}
	
}

