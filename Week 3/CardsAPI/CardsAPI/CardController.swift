//
//  CardController.swift
//  CardsAPI
//
//  Created by Owen Henley on 7/23/18.
//  Copyright © 2018 Owen Henley. All rights reserved.
//

import UIKit

class CardController {
    
        //  create a base URL to start the api call from.
    static let baseURL = URL(string: "https://deckofcardsapi.com/api/deck/new/draw/")
    
        // when they ask for a card, we need to give a card back.  completion is  "start this task, and tell me when its done."
    static func drawOneCard(count: Int, completion: @escaping (Card?) -> Void) {
        
            //1 - contruct the URL,
            //unwrap the URL, its changing so we need it a variable, call completion to run the completion bock when it camefrom
        guard var url = baseURL else { completion(nil) ; return }
        print("Unwrapped baseURL: \(url)")
        
            //URL componants to add query item. basically grab what you want. " ?count=1 "
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true) // componnets breaks the url up.
        
            //create query items
        let countQueryItem = URLQueryItem(name: "count",  value: "\(count)")
        
            // add query items to the components query items array
        components?.queryItems = [countQueryItem]
        
        // ?????????
        guard let requestURL = components?.url else { completion(nil) ; return}
        print(url)
        
            //2 - request the URL
        var request = URLRequest(url: requestURL)
        
            // 3 types of HTTP Methods:
                //GET - getting something from the server
                //POST - create new information to the server
                //PUT - updating something on teh server
        request.httpMethod = "GET"
        
            // ??????
        request.httpBody = nil
        
            // 3 - dataTask + Return
                // whoever calls this function, decides what happens with teh completion handler
        let dataTask = URLSession.shared.dataTask(with: requestURL) { (data, _, error) in
            if let error = error {
                print("there was an error getting a card: \(error.localizedDescription)")
                    // call completion
                completion(nil)
                    // return
                return
            }
            //we have data, now we have to unwrap it
            guard let data = data else { completion(nil) ; return }
            //received JSON, now i need to decode it to something we can use
            let jsonDecoder = JSONDecoder()
            do {
                    //top level object still so type is DECK
                let deck = try jsonDecoder.decode(Deck.self, from: data)
                    //decoded json, can now play with cards, unwrap first object in the deck
                guard let card = deck.cards.first else { completion(nil) ; return }
                completion(card) // completed, give the card back
            } catch {
                print("error decoding json: \(error.localizedDescription)")
            }
        }
        //VERY IMPORTANT
        dataTask.resume()
    }
    
    static func getImage(for card: Card, completion: @escaping (UIImage?) -> Void) {
        //contruct URL
        guard let url = URL(string: card.imageURLAsString) else { completion(nil) ; return }
        
        // url request
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.httpBody = nil
        
        // data task
        let dataTask = URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                print("there was an error getting the card image: \(error.localizedDescription)")
                completion(nil)
            }
            guard let imageData = data else { completion(nil) ; return }
            let image = UIImage(data: imageData)
            completion(image)
        }
        dataTask.resume()
    }
}
