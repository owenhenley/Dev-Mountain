//
//  UserController.swift
//  FavoriteApp20-2
//
//  Created by Frank Martin Jr on 7/25/18.
//  Copyright © 2018 Frank Martin Jr. All rights reserved.
//

import Foundation

class UserController {
    
    static let baseURL = URL(string: "https://favoriteapp-375c6.firebaseio.com")
    
    static func getUsers(completion: @escaping ([User]?) -> Void) {
        // Step 1 - Construct URL
        guard var url = baseURL else { completion(nil) ; return }
        
        // Add a slash
        url.appendPathComponent("users")
        // https://favoriteapp-375c6.firebaseio.com/users
        
        // Add a period
        url.appendPathExtension("json")
        // https://favoriteapp-375c6.firebaseio.com/users.json
        print(url)
        
        // Step 2 - Create the URL Request
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.httpBody = nil
        
        // Step 3 - DataTask + RESUME
        let dataTask = URLSession.shared.dataTask(with: request) { (data, _, error) in
            
            // Handle the error
            if let error = error {
                print("There was an error retrieving the posts: \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            // Handle the data
            guard let data = data else { completion(nil) ; return }
            do {
                guard let topLevelDictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: [String:String]] else { completion(nil) ; return }
                
                var users: [User] = []
                for (_, value) in topLevelDictionary {
                    guard let user = User(jsonDictionary: value) else { completion(nil) ; return }
                    users.append(user)
                }
                completion(users)
                
            } catch {
                print("There was an error serializing the data: \(error.localizedDescription)")
            }
            
        }
        dataTask.resume()
    }
    
    static func postNewUser(name: String, favApp: String, completion: @escaping (User?) -> Void) {
        // Step 1 - Construct URL
        guard var url = baseURL else { completion(nil) ; return }
        // https://favoriteapp-375c6.firebaseio.com
        
        url.appendPathComponent("users")
        // https://favoriteapp-375c6.firebaseio.com/users
        
        url.appendPathExtension("json")
        // https://favoriteapp-375c6.firebaseio.com/users.json
        print(url)
        
        // Step 2 - Request
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let newUser = User(name: name, favApp: favApp)
        
        let jsonDictionary = ["name" : newUser.name, "favApp" : newUser.favApp]
        
        do {
            let jsonDictionaryAsData =  try JSONSerialization.data(withJSONObject: jsonDictionary, options: .prettyPrinted)
            request.httpBody = jsonDictionaryAsData
            
        } catch {
            print("There was an error turning the model object into a JSON Dictionary: \(error.localizedDescription)")
            completion(nil)
            return
        }
        
        // Step 3 - DataTask + RESUME
        let dataTask = URLSession.shared.dataTask(with: request) { (_, _, error) in
            if let error = error {
                print("There was an error posting the data to server: \(error.localizedDescription)")
                completion(nil)
                return
            }
            completion(newUser)
        }
        dataTask.resume()
    }
}







