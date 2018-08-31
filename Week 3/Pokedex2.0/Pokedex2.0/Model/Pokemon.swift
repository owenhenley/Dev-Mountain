//
//  Pokemon.swift
//  Pokedex2.0
//
//  Created by Owen Henley on 7/24/18.
//  Copyright © 2018 Owen Henley. All rights reserved.
//

import Foundation

// creating a POKEMON from the jsaon info, decoding the json
struct Pokemon: Decodable {
    let name: String
    let weight: Int
    let id: Int
    let sprites: Sprite
}

// conform to codable to match the pokemon
struct Sprite: Decodable {
    // pull  the image from the url as a string
    let imageURLAsString: String
    
    // create a coding key to convert from default_front to image url as string
    enum CodingKeys: String, CodingKey {
        case imageURLAsString = "front_default"
    }
}
