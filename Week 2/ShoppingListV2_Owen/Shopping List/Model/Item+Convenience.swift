//
//  Item+Convenience.swift
//  Shopping List
//
//  Created by Owen Henley on 7/20/18.
//  Copyright © 2018 Owen Henley. All rights reserved.
//

import Foundation
import CoreData

extension Item {
    convenience init(name: String, managedObjectContext: NSManagedObjectContext = CoreDataStack.managedObjectContext) {
        self.init(context: managedObjectContext)
        self.name = name
    }
}
