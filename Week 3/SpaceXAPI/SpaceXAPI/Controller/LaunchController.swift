//
//  LaunchController.swift
//  SpaceXAPI
//
//  Created by Owen Henley on 7/24/18.
//  Copyright © 2018 Owen Henley. All rights reserved.
//

import UIKit

class LaunchController {
    
    static let baseURL = URL(string: "https://api.spacexdata.com/v2/launches")
    
    static func findLaunch(_ searchTerm: String, completion: @escaping (Flight?) -> Void) {
        
        //construct url
        
        guard let url = baseURL else {
            print("error getting url")
            completion(nil) ; return }
        
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true) // componnets breaks the url up.
        
        //create query items
        guard let intSearchTerm = Int(searchTerm) else { completion(nil); return }
        let countQueryItem = URLQueryItem(name: "flight_number",  value: "\(intSearchTerm)")
        
        // add query items to the components query items array
        components?.queryItems = [countQueryItem]
        guard let fullURL = components?.url else { completion(nil); return }
        
        var request = URLRequest(url: fullURL)
        request.httpMethod = "GET"
        request.httpBody = nil
        print("\(fullURL.absoluteString)")
        //DataTask Resume
        let dataTask = URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                print("error with URLSession: \(error.localizedDescription)")
                completion(nil) ; return }
            
            //unwrap data
            guard let data = data else {
                print("error unwrapping data") ; return }
            
            print(data)
            
            //decode data
            do {
                let jsonDecoder = JSONDecoder()
                let flightArray = try jsonDecoder.decode([Flight].self, from: data)
                guard let flight = flightArray.first else { completion(nil); return }
                completion(flight)
            } catch {
                print("**!!error decoding launch JSON!!**: \(error.localizedDescription)")
                completion(nil)
            }
        }
        dataTask.resume()
    }
    
    // GET IMAGE
    
    static func getMissionBadge(for launch: Flight, completion: @escaping ((UIImage?) -> Void)) {
        guard let urlForImage = URL(string: launch.links.missionPatchAsString) else {
            print("error with image url")
            completion(nil) ; return }
        
        let dataTask = URLSession.shared.dataTask(with: urlForImage) {(data, _, error) in
            if let error = error { print("error getting the image from url: \(error)")
                completion(nil) ; return }
            
            guard let unwrappedData = data else { print("no data received for launch")
                completion(nil) ; return }
            
            let image = UIImage(data: unwrappedData)
            completion(image)
    }
        dataTask.resume()
    }
}
