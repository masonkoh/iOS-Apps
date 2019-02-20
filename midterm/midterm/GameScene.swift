//
//  GameScene.swift
//  midterm
//
//  Created by Mason Ko on 2019-02-20.
//  Copyright © 2019 Mason Ko. All rights reserved.
//

import SpriteKit
import GameplayKit



class GameScene: SKScene, SKPhysicsContactDelegate {
    var player1: SKSpriteNode!
    var player2: SKSpriteNode!
    var player1hp: SKLabelNode!
    var player2hp: SKLabelNode!
    var player1health: Int = 100 {
        didSet {
            player1hp.text = "PLAYER1HP: \(player1health)"
        }
    }
    var player2health: Int = 100 {
        didSet {
            player2hp.text = "PLAYER2HP: \(player2health)"
        }
    }
    var bullet: SKSpriteNode!

    
    
    
    

    
    override func didMove(to view: SKView) {
        setupPhysics()
        player1 = self.childNode(withName: "player1") as! SKSpriteNode;
        player2 = self.childNode(withName: "player2") as! SKSpriteNode;
        player1hp = self.childNode(withName: "player1health") as! SKLabelNode;
        player2hp = self.childNode(withName: "player2health") as! SKLabelNode;
        bullet = self.childNode(withName: "bullet") as! SKSpriteNode;
        
        bullet.physicsBody?.applyImpulse(CGVector(dx: 50, dy: 50))
        
        let border = SKPhysicsBody(edgeLoopFrom: (view.scene?.frame)!)
        border.friction = 0
        self.physicsBody = border
        
        self.physicsWorld.contactDelegate = self

    }
    
    func setupPhysics(){
        physicsWorld.gravity = CGVector(dx: 0.0, dy: -2.0)
        physicsWorld.contactDelegate = self as? SKPhysicsContactDelegate
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        let bodyAName = contact.bodyA.node?.name
        let bodyBName = contact.bodyB.node?.name
        
        if bodyAName == "bullet" && bodyBName == "player1" || bodyAName == "player1" && bodyBName == "bullet"
            || bodyAName == "bullet" && bodyBName == "player2" || bodyAName == "player2" && bodyBName == "bullet"{
            if bodyAName == "player1" {
                player1health == 100
            } else if bodyBName == "player1"{
                player1health == 100
            } else if bodyAName == "player2" {
                player2health == 100
            } else if bodyBName == "player2"{
                player2health == 100
            }
        }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        if(player1health <= 0){
            player1hp.text = "GAME OVER"
            self.view?.isPaused = true
        }
        if(player2health <= 0){
            player2hp.text = "GAME OVER"
            self.view?.isPaused = true
        }
    }
    
    
}
