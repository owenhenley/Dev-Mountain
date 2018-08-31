//
//  Entry.swift
//  Journal2.0
//
//  Created by Owen Henley on 7/5/18.
//  Copyright © 2018 Owen Henley. All rights reserved.
//

import Foundation

class Entry: Equatable, Codable {
    static func == (lhs: Entry, rhs: Entry) -> Bool {
        return lhs.title == rhs.title && lhs.body == rhs.body && lhs.timestamp == rhs.timestamp
    }
    
    var title: String
    var body: String
    var timestamp: Date //date formatter class to fix uglyness
    
    init(title: String, body: String) {
        self.title = title
        self.body = body
        self.timestamp = Date()
    }
}






