//
//  Item+Convenience.swift
//  BucketList
//
//  Created by Owen Henley on 7/19/18.
//  Copyright © 2018 Owen Henley. All rights reserved.
//

import Foundation
import CoreData

extension Item {
    convenience init(name: String, manageObjectContext: NSManagedObjectContext = CoreDataStack.managedObjectContext) {
        self.init(context: manageObjectContext)
        self.name = name
    }
}
