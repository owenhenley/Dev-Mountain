//
//  Note.swift
//  NotesV2
//
//  Created by Owen Henley on 7/19/18.
//  Copyright © 2018 Owen Henley. All rights reserved.
//

import Foundation

class Note: Codable {
    var bodyText: String
    
    init(bodytext: String) {
        self.bodyText = bodytext
    }
}

extension Note: Equatable {
    static func == (lhs: Note, rhs: Note) -> Bool {
        return lhs.bodyText == rhs.bodyText
    }
    
    
}
