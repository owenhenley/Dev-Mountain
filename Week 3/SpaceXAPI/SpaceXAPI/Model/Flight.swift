//
//  Launch.swift
//  SpaceXAPI
//
//  Created by Owen Henley on 7/24/18.
//  Copyright © 2018 Owen Henley. All rights reserved.
//

import UIKit

struct Flight: Decodable {
    let flightNumber: Int
    let launchYearAsString: String
    let launchSuccess: Bool
    let details: String?
    let links: Links
    let launchSite: LaunchSite
    let rocket: Rocket
    
    enum CodingKeys: String, CodingKey {
        case flightNumber = "flight_number"
        case launchYearAsString = "launch_year"
        case launchSuccess = "launch_success"
        case links
        case launchSite = "launch_site"
        case rocket
        case details
    }
    
}

// Mission patch UIImage
struct Links: Decodable {
    let missionPatchAsString: String
    
    enum CodingKeys: String, CodingKey{
        case missionPatchAsString = "mission_patch"
    }
}

// Rocket Info
struct Rocket: Decodable {
    let rocketNameAsString: String
    let rocketTypeAsString: String
    
    enum CodingKeys: String, CodingKey {
        case rocketNameAsString = "rocket_name"
        case rocketTypeAsString = "rocket_type"
    }
}

struct LaunchSite: Decodable {
    let siteNameAsString: String
    
    enum CodingKeys: String, CodingKey {
        case siteNameAsString = "site_name"
    }
}


