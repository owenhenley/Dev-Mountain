//
//  User.swift
//  FavoriteApp20-2
//
//  Created by Frank Martin Jr on 7/25/18.
//  Copyright © 2018 Frank Martin Jr. All rights reserved.
//

import Foundation

struct User {
    let name: String
    let favApp: String
    
    private let nameKey = "name"
    private let favAppKey = "favApp"
    
    init(name: String, favApp: String) {
        self.name = name
        self.favApp = favApp
    }
    
    init?(jsonDictionary: [String : String]) {
        guard let name = jsonDictionary[nameKey],
            let favApp = jsonDictionary[favAppKey]
            else { return nil }
        
        self.name = name
        self.favApp = favApp
    }
    
//    var asJSONDictionary: [String : Any] {
//        return ["name" : name, "favApp" : favApp]
//    }
}
