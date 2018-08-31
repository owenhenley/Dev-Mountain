//
//  Message.swift
//  BulletinBoard2.0
//
//  Created by Owen Henley on 8/6/18.
//  Copyright © 2018 Owen Henley. All rights reserved.
//

import Foundation
import CloudKit

struct Message {
	
	let messageText: String
	let timestamp: Date
	
	static let messageTypeKey = "Message"
	fileprivate static let messageTextKey = "messageText"
	fileprivate static let timestampKey = "timestamp"
	
	init(messageText: String, timestamp: Date = Date()) {
		self.messageText = messageText
		self.timestamp = timestamp
	}
	
		// Turn our CKRecord into a message Model Object
			//CKRecord is basicslaly a glorified dictionary
	init?(ckRecord: CKRecord) {
		guard let messageText = ckRecord[Message.messageTextKey] as? String,
			let timestamp = ckRecord[Message.timestampKey] as? Date
			else { return nil }
		
		self.messageText = messageText
		self.timestamp = timestamp
	}
}

// extensing CKRecord because were setting an istance for CKRecord NOT message
extension CKRecord {
	
	// Create an init to set the values
	convenience init(message: Message) {
		// You have to call a designatied initialiser
		self.init(recordType: Message.messageTypeKey)
		
		//Set values
		self.setValue(message.messageText, forKey: Message.messageTextKey)
		self.setValue(message.timestamp, forKey: Message.timestampKey)
	}
}
