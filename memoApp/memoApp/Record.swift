//
//  Record.swift
//  memoApp
//
//  Created by Mason Ko on 2019-02-16.
//  Copyright © 2019 Mason Ko. All rights reserved.
//

import UIKit

class Record: UIViewController {
    // MARK: - Variable
    @IBOutlet weak var RecordTextView: UITextView!
    var memoData = [String]();
    // Variable_End
    
    override func viewDidLoad() {
        super.viewDidLoad();
        let memoNo = UserDefaults.standard.object(forKey: "memoNo") as! Int;
        
        if memoNo == -1 {
            memoData = UserDefaults.standard.object(forKey: "memoData") as? [String] ?? [String]();
            RecordTextView.text = "";
        } else {
            memoData = UserDefaults.standard.object(forKey: "memoData") as! [String];
            RecordTextView.text = memoData[memoNo];
        }
    }
    
    // MARK: - Action
    @IBAction func Save(_ sender: Any) {
        let memoNo = UserDefaults.standard.object(forKey: "memoNo") as! Int;
        
        if memoNo == -1 {
            memoData.insert(RecordTextView.text, at: 0);
            UserDefaults.standard.set(memoData, forKey: "memoData");
        } else {
            memoData.remove(at: memoNo);
            memoData.insert(RecordTextView.text, at: memoNo);
            UserDefaults.standard.set(memoData, forKey: "memoData");
        }
    }
    
    @IBAction func resetText(_ sender: Any) {
        RecordTextView.text = ""
    }
    
    @IBAction func deleteMemo(_ sender: Any) {
        let memoNo = UserDefaults.standard.object(forKey: "memoNo") as! Int;
        if memoNo != -1{
            memoData.remove(at: memoNo);
            UserDefaults.standard.set(memoData, forKey: "memoData");
        }
    }
    // ACTION_END
}
