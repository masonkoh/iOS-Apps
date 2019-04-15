//
//  GameScene.swift
//  Spaceship Gun Fight
//
//  Created by Mason Ko on 2019-04-14.
//  Copyright © 2019 Mason Youngmin Ko. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    var starfield:  SKEmitterNode!
    var player:     SKSpriteNode!
    var scoreLabel:      SKLabelNode!
    var score: Int = 0{
        didSet{
            scoreLabel.text = "Score: \(score)"
        }
    }
    var gameTimer: Timer!
    var possibleAliens = ["alien", "alien2", "alien3"]
    
    let alienCategory: UInt32 = 0x1 << 1
    let photonTorpedoCategory: UInt32 = 0x1 << 0
    
    
    override func didMove(to view: SKView) {
        starfield = SKEmitterNode(fileNamed: "Starfield")
        starfield.position = CGPoint(x: 0, y: 1472)
        starfield.advanceSimulationTime(10)
        self.addChild(starfield)
        starfield.zPosition = -1
        
        player = SKSpriteNode(imageNamed: "shuttle")
        // MK_NOTE: ASK PRATIK
//        player.position = CGPoint(x: self.frame.width, y: player.size.height / 2 + 20)
        player.position = CGPoint(x: 0, y: (-self.frame.width) + 200)
        self.addChild(player)
        
        scoreLabel = SKLabelNode(text: "Score: \(score)")
        scoreLabel.position = CGPoint(x: self.frame.width - 550, y: self.frame.height - 780)
        print(self.frame.width)
        print(self.frame.height)
        scoreLabel.fontName = "AmericanTypewriter-Bold"
        scoreLabel.fontSize = 36
        scoreLabel.fontColor = UIColor.white
        self.addChild(scoreLabel)
        
        gameTimer = Timer.scheduledTimer(timeInterval: 0.75, target: self, selector: #selector(addAlien), userInfo: nil, repeats: true)
        
        self.physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        self.physicsWorld.contactDelegate = self
    }
    override func update(_ currentTime: TimeInterval) {
        // called before each frame is rendered
    }
    
    @objc func addAlien(){
        possibleAliens = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: possibleAliens) as! [String]
        let alien = SKSpriteNode(imageNamed: possibleAliens[0])
        let randomAlienPosition = GKRandomDistribution(lowestValue: 0, highestValue: 414)
        let position = CGFloat(randomAlienPosition.nextInt())
        alien.position = CGPoint(x: position, y: frame.size.height + alien.size.height)
        alien.physicsBody = SKPhysicsBody(rectangleOf: alien.size)
        alien.physicsBody?.isDynamic = true
        
        addChild(alien)
    }
}
