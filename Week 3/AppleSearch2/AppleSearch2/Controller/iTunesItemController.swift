//
//  iTunesItemController.swift
//  AppleSearch2
//
//  Created by Owen Henley on 7/26/18.
//  Copyright © 2018 Owen Henley. All rights reserved.
//

import UIKit

class iTunesItemController {
    
    // shared instance
    static var shared = iTunesItemController()
    // acess to teh array
    var iTunesItems: [iTunesItem] = []
    
    let baseURL = URL(string: "https://itunes.apple.com")
    
    func getiTunesItems(for searchTerm: String, completion: @escaping (Bool) -> Void) {
        // construct url
        // unwrap url
        guard var url = baseURL else { completion(false); return }
        //append componant
        url.appendPathComponent("search")
        // https://itunes.apple.com/
        
        // query item
        //url componants
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        //create query items
        let searchTermQueryItem = URLQueryItem(name: "term", value: searchTerm)
        // https://itunes.apple.com/search?term=searchTerm
        
        // what do we want to search?
        let mediaQueryItem = URLQueryItem(name: "media", value: "music")
        
        //set query item compnantas to be our arrya of items
        components?.queryItems = [searchTermQueryItem, mediaQueryItem]
        
        // unwrap url so we can request it. request url
        guard let requestURL = components?.url else { completion(false); return}
        
        // step 2 creat requesy - not nessacery
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = "GET"
        request.httpBody = nil
        
        //step 3
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                print("error getting sesrch results: \(error.localizedDescription)")
                completion(false)
                return
            }
            guard let data = data else { completion(false); return }
            
            do {
                let jsonDecoder = JSONDecoder()
                let topLevelDict = try jsonDecoder.decode(TopLevelDictionary.self, from: data)
                let iTunesItems = topLevelDict.results
                self.iTunesItems = iTunesItems
                completion(true)
            } catch {
                print("**!!error decoding json!!**: \(error.localizedDescription)")
                completion(false)
                return
            }
        }.resume()
    }
    
    func getImage(for iTunesItem: iTunesItem, completion: @escaping (UIImage?) -> Void) {
        // step 1
        guard let url = URL(string: iTunesItem.imageUrlAsString) else { completion(nil); return}
        // step 2 - requst
        //step 3
        let dataTask = URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                print(" there was an error gettin the image: \(error.localizedDescription)")
                completion(nil)
                return
            }
            guard let data = data else { completion(nil); return }
            let image = UIImage (data: data)
            completion(image)
        }
        dataTask.resume()
    }
    
}
