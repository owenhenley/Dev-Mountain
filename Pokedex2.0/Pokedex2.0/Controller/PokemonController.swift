//
//  PokemonController.swift
//  Pokedex2.0
//
//  Created by Owen Henley on 7/24/18.
//  Copyright © 2018 Owen Henley. All rights reserved.
//

import UIKit

class PokemonController {
    
    // get base URL
    static let baseURL = URL(string: "https://pokeapi.co/api/v2/")
    
    static func searchForPokemon(_ searchTerm: String, completion: @escaping (Pokemon?) -> Void) {
        
        //1- contrict URL
        guard var url = baseURL else { completion(nil) ; return }
        
        // add the path we what to search
        url.appendPathComponent("pokemon")
        // what to we want to use to find what we want
        url.appendPathComponent("\(searchTerm.lowercased())")
    
        //2 - create url request - not entirly neccasary, this is for practice and exposure
        var request = URLRequest(url: url)
        //we want to GET info
        request.httpMethod = "GET"
        request.httpBody = nil
        
        //3 - datatask Resume
        let dataTask = URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                print("error with URLSession: \(error.localizedDescription)")
                completion(nil) ; return }
            
            // unwrap 'data'
            guard let data = data else { completion(nil) ; return }
            
            // decode data
            do {
                let jsonDecoder = JSONDecoder()
                let pokemon = try jsonDecoder.decode(Pokemon.self, from: data)
                // it worked! call completion, send it back to the caller
                completion(pokemon)
            } catch {
                completion(nil)
                print("**!error decoding a pokemon!**: \(error.localizedDescription)")
            }
        }
        // IMPORTANT
        dataTask.resume()
    }
    
    // Get the pokemon image
    // network call so we need a completion block
    // return an image that might not come back - void
    static func getPokemonImage(for pokemon: Pokemon, completion: @escaping ((UIImage?) -> Void)) {
        
        //step 1 - contstruct URL
        guard let urlForImage = URL(string: pokemon.sprites.imageURLAsString) else { print("error with image URL")
            completion(nil) ; return }
        
        // step 2 url request - use for header auth liek fortnight tracker/halo tracker
        
        
        //3 - Datatask resume
        let dataTask = URLSession.shared.dataTask(with: urlForImage) {(data,_,error) in
            if let error = error { print("error gettting the image")
                completion(nil) ; return }
            
            guard let data = data else { print("no data received for pokemon")
                completion(nil) ; return }
            
            let image = UIImage(data: data)
            completion(image)
        }
        dataTask.resume()
    }
}

