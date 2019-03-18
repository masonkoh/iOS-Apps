//
//  ViewController.swift
//  gesture_swipe_tap_intro
//
//  Created by Mason Ko on 2019-03-18.
//  Copyright © 2019 Mason Ko. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    
    @IBAction func mySwipeToRightHandler(_ sender: Any) {
        let randomNo : Int = Int(arc4random() % 100)
        print("image swiped to right -  " + String(randomNo))
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }


}

