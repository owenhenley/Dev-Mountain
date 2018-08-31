//
//  ViewController.swift
//  CardsAPI
//
//  Created by Owen Henley on 7/22/18.
//  Copyright © 2018 Owen Henley. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var cardImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func drawCardButtonPressed(_ sender: UIButton) {
        // when tapped, draw a card
        CardController.drawOneCard(count: 1) { (card) in
            // unwrap the card
            guard let card = card else { return }
            //if success, get teh image too
            CardController.getImage(for: card, completion: { (cardImage) in
                // change back to the main queue
                DispatchQueue.main.async {
                    self.cardImageView.image = cardImage
                }
            })
        }
    }
}

