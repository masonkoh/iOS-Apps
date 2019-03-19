//
//  ViewController.swift
//  gesture_swipe_tap_intro
//
//  Created by Mason Ko on 2019-03-18.
//  Copyright © 2019 Mason Ko. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var myPinchLabel: UILabel!
    @IBOutlet weak var myTapLabel: UILabel!
    
    // function returns String(randomNo) for debugging purpose
    func randomNo() -> String {
        let randomNo : Int = Int(arc4random() & 100)
        return String(randomNo)
    }
    
    @IBAction func mySwipeToRightHandler(_ sender: Any) {
        print("image swiped to right -  " + randomNo())
    }
    @IBAction func mySwipeToLeftHandler(_ sender: Any) {
        print("image swiped to left -  " + randomNo())
    }
    @IBAction func myTripleTappingImageHandler(_ sender: Any) {
        print("image tapped (triple touch!)- " + randomNo())
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // 'tr' refers to 'tap recognizer'
        let tr = UITapGestureRecognizer(target: self, action: #selector(ViewController.myTapLabelTapped(recognizer:)))
        // 'pr' refers to 'pinch recognizer'
        let pr = UIPinchGestureRecognizer(target: self, action: #selector(ViewController.myPinchLabelPinched(recognizer:)))
        tr.numberOfTapsRequired = 2
        myPinchLabel.isUserInteractionEnabled = true
        myTapLabel.addGestureRecognizer(tr)
        myPinchLabel.addGestureRecognizer(pr)
        
        
    }
    
    @objc func myTapLabelTapped(recognizer: UITapGestureRecognizer){
        print("label(TAP ME!) double tapped - " + randomNo())
    }
    @objc func myPinchLabelPinched(recognizer: UIPinchGestureRecognizer){
        print("label(PINCH ME!) pinched - " + randomNo())
    }
    
    
}

