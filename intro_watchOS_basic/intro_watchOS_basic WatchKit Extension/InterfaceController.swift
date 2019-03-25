//
//  InterfaceController.swift
//  intro_watchOS_basic WatchKit Extension
//
//  Created by Mason Ko on 2019-03-25.
//  Copyright © 2019 Mason Ko. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {

    @IBOutlet weak var lbl: WKInterfaceLabel!
    @IBOutlet weak var clickButton: WKInterfaceButton!
    
    // purpose of randomNo() is to make each console message unique. easier to see
    func randomNo() -> String {
        return String(arc4random() % 100)
    }
    
    @IBAction func storeHandler() {
        print("store!: " + randomNo())
        // how to write a value for a variable
        UserDefaults.standard.set(arc4random()%100, forKey: "heartRate")
        UserDefaults.standard.synchronize()
        print(UserDefaults.standard.value(forKey: "heartRate"))
    }
    
    @IBAction func retrieveHandler() {
        print("retrieve!: " + randomNo())
        // to retireve value
        var heartRate = UserDefaults.standard.value(forKey: "heartRate")
        var heartRateValues = UserDefaults.standard.array(forKey: "heartRate") as? [Int8]
        lbl.setText("HR is + \(heartRate!)")
    }
    
    @IBAction func playHandler() {
        print("play!: " + randomNo())
    }
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
    }
    
    
    @IBAction func clickHandler() {
        print("clicked!: " + randomNo())
    }
    
    
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
