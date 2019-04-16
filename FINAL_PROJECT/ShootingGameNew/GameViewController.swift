//
//  GameViewController.swift
//  ShootingGameNew
//
//  Created by Fenil Shah on 2019-04-07.
//  Copyright © 2019 Fenil Shah. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit
import CoreData

class GameViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var name = ""
    var score = 0
    var highScores: [(score: Int32, name: String)] = []
    var finalHighScore: [(score: Int32, name: String)] = []
    
    @IBOutlet weak var lbl_title: UILabel!
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var newGameBtn: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        printUsers()
        self.hideKeyboardWhenTappedAround()
//        if let view = self.view as! SKView? {
//            // Load the SKScene from 'GameScene.sks'
//            if let scene = SKScene(fileNamed: "GameScene") {
//                // Set the scale mode to scale to fit the window
//                scene.scaleMode = .aspectFill
//
//                // Present the scene
//                view.presentScene(scene)
//            }
//
//            view.ignoresSiblingOrder = true
//
//            view.showsFPS = true
//            view.showsNodeCount = true
//        }
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    
    @IBAction func newGameAction(_ sender: Any) {
        lbl_title.isHidden = true
        name = nameText.text!
        print(name)
        nameText.text! = ""
        nameText.isHidden = true
        newGameBtn.isHidden = true
        table.isHidden = true
        
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "GameScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                
                // Present the scene
                view.presentScene(scene)
            }
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
            
            setRecord()
        }
    }
    
    func setRecord()
    {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let newUser = NSEntityDescription.insertNewObject(forEntityName: "UserData", into: context)
        
        newUser.setValue(name, forKey: "name")
        newUser.setValue(-1, forKey: "score")
        
        do{
            try context.save()
        }
        catch {
            print("Error!!!")
        }
    }
    
    @objc func printUsers()
    {
//        highScores.removeAll()
//        finalHighScore.removeAll()

        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "UserData")
        request.returnsObjectsAsFaults = false
        
        do {
            let results = try context.fetch(request)
            
            if results.count > 0 {
                
                for result in results as! [NSManagedObject] {
                    
                    let temp = (score: result.value(forKey: "score"), name: result.value(forKey: "name"))
                    highScores.append(temp as! (score: Int32, name: String))
                }
                highScores = highScores.sorted(by:{$0.score>$1.score})
                print(highScores.capacity)
                print(finalHighScore.capacity)
                var i = 0
                while (i < 10)
                {
                    finalHighScore.insert(highScores[i], at: i)
                    i+=1
                }
                
                
                print(finalHighScore.capacity)
            }
            else {
                print("No Result!!")
            }
            
            
        }
            
        catch {
            print("Error when fetching Data!!")
        }
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return(finalHighScore.count)
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier : "cell")
        cell.textLabel?.text = String("\(finalHighScore[indexPath.row].name) : \(finalHighScore[indexPath.row].score)")
        return(cell)
    }
    
}


extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    

}
