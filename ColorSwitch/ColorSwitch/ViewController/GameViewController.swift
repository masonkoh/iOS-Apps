//
//  GameViewController.swift
//  ColorSwitch
//
//  Created by Mason Ko on 2019-02-19.
//  Copyright © 2019 Mason Ko. All rights reserved.
//

import UIKit
import SpriteKit


class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            let scene = GameScene(size: view.bounds.size)
                // set the scale mode to scale to fit the window
            scene.scaleMode = .aspectFit
                
                // Present the scene
                view.presentScene(scene)
            
            
            view.ignoresSiblingOrder = true
            view.showsFPS = true
            view.showsNodeCount =  true
        }
        
        
    }
}
