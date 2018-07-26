//
//  iTunesItem.swift
//  AppleSearch2
//
//  Created by Owen Henley on 7/26/18.
//  Copyright © 2018 Owen Henley. All rights reserved.
//

import Foundation

struct TopLevelDictionary: Decodable{
    // we want an arry of itunes items
    let results: [iTunesItem]
    
}

struct iTunesItem: Decodable {
    let artistName: String
    let albumName: String
    let trackName: String
    let imageUrlAsString: String
    
    enum CodingKeys: String, CodingKey {
        case artistName
        case albumName = "collectionName"
        case trackName
        case imageUrlAsString = "artworkUrl100"
    }
}
