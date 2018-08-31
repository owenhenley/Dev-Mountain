//
//  ViewController.swift
//  Flashlight
//
//  Created by Owen Henley on 7/2/18.
//  Copyright © 2018 Owen Henley. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var lightswitch: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    var isOn = false
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        onOffLogic()
    }
    
    func whenOn() {
        lightswitch.isSelected = true
        view.backgroundColor = .black
        lightswitch.setTitle("ON", for: .normal)
        print("selected ON")
        lightswitch.isSelected = false
    }

    func whenOff() {
        lightswitch.isSelected = false
        view.backgroundColor = .white
        lightswitch.setTitle("OFF", for: .normal)
        print("selected OFF")
        lightswitch.isSelected = true
    }
    
    func onOffLogic() {
        if lightswitch.isSelected == true {
           whenOn()
        }
        else {
           if lightswitch.isSelected == false {
            whenOff()
            }
        }
            
    }
    
// @IBAction func tappedOff(_ sender: UIButton) {
//        if isOn == true {
//           isOn = false
//           view.backgroundColor = .black
//        }
//    }
//}
    
}
