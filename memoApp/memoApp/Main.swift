//
//  ViewController.swift
//  memoApp
//
//  Created by Mason Ko on 2019-02-16.
//  Copyright © 2019 Mason Ko. All rights reserved.
//

import UIKit

class Main: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var memoData = [String]();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    // MARK: - Table
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        memoData = UserDefaults.standard.object(forKey: "memoData") as? [String] ?? [String]();
        return memoData.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let Cell = tableView.dequeueReusableCell(withIdentifier: "MemoCell", for: indexPath) as! MainCell;
        memoData = UserDefaults.standard.object(forKey: "memoData") as? [String] ?? [String]();
        Cell.TitleLabel.text = memoData[indexPath.row];
        return Cell;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let memoNo = indexPath.row;
        UserDefaults.standard.set(memoNo, forKey: "memoNo");
        
        self.performSegue(withIdentifier: "toRecord", sender: self);
    }
    // Table_End
    
    // MARK: - Action
    @IBAction func addMemo(_ sender: Any) {
        UserDefaults.standard.set(-1, forKey: "memoNo")
    }
    // Action_End
}
