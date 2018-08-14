//
//  StudentDetailViewController.swift
//  Student List
//
//  Created by Owen Henley on 7/3/18.
//  Copyright © 2018 Owen Henley. All rights reserved.
//

import UIKit

class StudentDetailViewController: UIViewController {
    
    private func updateViews() {
        guard let student = student, isViewLoaded else { return }
        
        firstNameLabel.text = student.firstName
        lastNameLabel.text = student.lastName
        ageLabel.text = "\(student.age)"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateViews()
    }
    
    var student: Student? {
        didSet {
            updateViews()
        }
    }
    
    //MARK: OUTLETS
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    
    
}
