//
//  GameScene.swift
//  lastMinute
//
//  Created by Mason Ko on 2019-02-20.
//  Copyright © 2019 Mason Ko. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    var ball: SKSpriteNode!
    var paddle: SKSpriteNode!
    
    override func didMove(to view: SKView) {
        ball = self.childNode(withName: "ball") as! SKSpriteNode
        paddle = self.childNode(withName: "paddle") as! SKSpriteNode
        
        ball.physicsBody?.applyImpulse(CGVector(dx: 50, dy: 50))
        
        let border = SKPhysicsBody(edgeLoopFrom: (view.scene?.frame)!)
    }
    
}
