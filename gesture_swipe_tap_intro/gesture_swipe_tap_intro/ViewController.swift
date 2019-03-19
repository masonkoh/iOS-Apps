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
    @IBOutlet weak var myConsoleMsgLabel: UILabel!
    
    // function returns String(randomNo) for debugging purpose
    func randomNo() -> String {
        let randomNo : Int = Int(arc4random() & 100)
        return String(randomNo)
    }
    func displayConsoleMsgOnLabel(consoleMsg: String) -> Void{
        myConsoleMsgLabel.text = consoleMsg
    }
    
    
    @IBAction func mySwipeToRightHandler(_ sender: Any) {
        displayConsoleMsgOnLabel(consoleMsg: "image swiped to right -  " + randomNo())
        print("image swiped to right -  " + randomNo())
    }
    @IBAction func mySwipeToLeftHandler(_ sender: Any) {
        displayConsoleMsgOnLabel(consoleMsg: "image swiped to left -  " + randomNo())
        print("image swiped to left -  " + randomNo())
    }
    @IBAction func myTripleTappingImageHandler(_ sender: Any) {
        displayConsoleMsgOnLabel(consoleMsg: "image tapped (triple touch!)- " + randomNo())
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
        displayConsoleMsgOnLabel(consoleMsg: "label(TAP ME!) double tapped - " + randomNo())
        print("label(TAP ME!) double tapped - " + randomNo())
    }
    @objc func myPinchLabelPinched(recognizer: UIPinchGestureRecognizer){
        displayConsoleMsgOnLabel(consoleMsg: "label(PINCH ME!) pinched - " + randomNo())
        print("label(PINCH ME!) pinched - " + randomNo())
    }
    
    
}

