//
//  DetailViewController.swift
//  DaysOfTheWeek
//
//  Created by Owen Henley on 7/3/18.
//  Copyright © 2018 Owen Henley. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = day
    }
    
    //MARK: Properties
    
    var day: String = ""

}
