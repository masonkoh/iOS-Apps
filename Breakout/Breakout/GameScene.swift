//
//  GameScene.swift
//  Breakout
//
//  Created by Mason Ko on 2019-02-20.
//  Copyright © 2019 Mason Ko. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    var ball: SKSpriteNode!
    var paddle: SKSpriteNode!
    var scoreLabel: SKLabelNode!
    var score: Int = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    
    
    
    override func didMove(to view: SKView) {
        ball = self.childNode(withName: "Ball") as! SKSpriteNode;
        paddle = self.childNode(withName: "Paddle") as! SKSpriteNode;
        scoreLabel = self.childNode(withName: "Score") as! SKLabelNode;
        
        ball.physicsBody?.applyImpulse(CGVector(dx: 50, dy: 50))
        
        let border = SKPhysicsBody(edgeLoopFrom: (view.scene?.frame)!)
        border.friction = 0
        self.physicsBody = border
        
        self.physicsWorld.contactDelegate = self
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches{
            let touchLocation = touch.location(in: self)
            paddle.position.x = touchLocation.x
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let touchLocation = touch.location(in: self)
            paddle.position.x = touchLocation.x
        }
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        let bodyAName = contact.bodyA.node?.name
        let bodyBName = contact.bodyB.node?.name
        
        if bodyAName == "Ball" && bodyBName == "Brick3" || bodyAName == "Brick3" && bodyBName == "Ball"
            || bodyAName == "Ball" && bodyBName == "Brick2" || bodyAName == "Brick2" && bodyBName == "Ball"
            || bodyAName == "Ball" && bodyBName == "Brick1" || bodyAName == "Brick1" && bodyBName == "Ball"{
            if bodyAName == "Brick3" {
                contact.bodyA.node?.removeFromParent()
                score += 3
            } else if bodyBName == "Brick3"{
                contact.bodyB.node?.removeFromParent()
                score += 3
            } else if bodyAName == "Brick2" {
                contact.bodyA.node?.removeFromParent()
                score += 2
            } else if bodyBName == "Brick2"{
                contact.bodyB.node?.removeFromParent()
                score += 2
            } else if bodyAName == "Brick1" {
                contact.bodyA.node?.removeFromParent()
                score += 1
            } else if bodyBName == "Brick1"{
                contact.bodyB.node?.removeFromParent()
                score += 1
            }
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        // game over logic
        if(score >= 18){
            scoreLabel.text = "GAME OVER, Score: \(score)"
            self.view?.isPaused = true
        }
        // losing logic
        if(ball.position.y < paddle.position.y){
            scoreLabel.text = "YOU LOST, Score: \(score)"
            self.view?.isPaused = true
        }
    }
    
    
}

