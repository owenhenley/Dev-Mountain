//
//  PokedexViewController.swift
//  Pokedex2.0
//
//  Created by Owen Henley on 7/24/18.
//  Copyright © 2018 Owen Henley. All rights reserved.
//

import UIKit

// use a seachbar delegate to help with tehg pricess
class PokedexViewController: UIViewController {
    
    @IBOutlet weak var pokeSearchBar: UISearchBar!
    @IBOutlet weak var pokeImageView: UIImageView!
    @IBOutlet weak var pokeNameLabel: UILabel!
    @IBOutlet weak var pokeWeightLabel: UILabel!
    @IBOutlet weak var pokeIDLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pokeSearchBar.delegate = self
    }
}

extension PokedexViewController: UISearchBarDelegate {
    // hey, someone clicked the search bar burton
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        // get the search text out of teh search bar
        guard let searchText = searchBar.text, !searchText.isEmpty else { return }
        
        //hide keyboard
        searchBar.resignFirstResponder()
        
        // search for the pokemon with that text
        PokemonController.searchForPokemon(searchText) { (pokemon) in
            guard let unwrappedPokemon = pokemon else { return }
            
            // get the image
            PokemonController.getPokemonImage(for: unwrappedPokemon, completion: { (image) in
                
                //self because inside a closure. need an explicit reference
                //now we have the pokemon, move teh info to the main queue
                DispatchQueue.main.async {
                    self.pokeSearchBar.text = ""
                    self.pokeNameLabel.text = unwrappedPokemon.name
                    self.pokeWeightLabel.text = "\(unwrappedPokemon.weight)"
                    self.pokeIDLabel.text = "\(unwrappedPokemon.id)"
                    self.pokeImageView.image = image
                }
            })
        }
    }
}
