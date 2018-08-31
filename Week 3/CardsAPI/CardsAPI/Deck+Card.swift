//
//  Deck+Card.swift
//  CardsAPI
//
//  Created by Owen Henley on 7/22/18.
//  Copyright © 2018 Owen Henley. All rights reserved.
//

import UIKit

//a deck is full of an array of cards
struct Deck: Decodable { // decode the json to a model object
    let cards: [Card]
}

// api has a image, value, suit and a code. to get these value we must put them in the card model. exactly as written in the api
struct Card: Decodable {
    
    // Take the info from the API
    let imageURLAsString: String
    let value: String
    let suit: String
    
    // because image URL as string isnt in the API, you need to tell it what its referring to with an enum
    enum CodingKeys: String, CodingKey {
        case imageURLAsString = "image"
        case value
        case suit
    }
}
