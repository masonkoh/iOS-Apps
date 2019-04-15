//
//  GameScene.swift
//  ShootingGameNew
//
//  Created by Fenil Shah on 2019-04-07.
//  Copyright © 2019 Fenil Shah. All rights reserved.
//

import SpriteKit
import CoreMotion
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var starfield:SKEmitterNode!
    var player:SKSpriteNode!
    
    var scoreLabel:SKLabelNode!
    var score:Int = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    
    var gameTimer:Timer!
    var bulletTimer:Timer!
    var possibleAliens = ["alien1", "alien2"]
    
    let alienCategory:UInt32 = 0x1 << 1
    let bulletCategory:UInt32 = 0x1 << 0
    
    override func didMove(to view: SKView) {

        starfield = SKEmitterNode(fileNamed: "Starfield")
        starfield.position = CGPoint(x: 0, y: 1472)
        starfield.advanceSimulationTime(10)
        self.addChild(starfield)
        
        starfield.zPosition = -1
        
        player = SKSpriteNode(imageNamed: "spaceship")
        print(size.width)
        player.position = CGPoint(x: 0, y: -self.size.height/2.5)

        self.addChild(player)
        
        self.physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        self.physicsWorld.contactDelegate = self
        
        scoreLabel = SKLabelNode(text: "Score: 0")
        scoreLabel.position = CGPoint(x: (-size.width/2) + 100, y: self.frame.size.height/2 - 35)
        scoreLabel.fontName = "AmericanTypewriter-Bold"
        scoreLabel.fontSize = 36
        scoreLabel.fontColor = UIColor.white
        score = 0
        
        self.addChild(scoreLabel)
        
        gameTimer = Timer.scheduledTimer(timeInterval: 0.50, target: self, selector: #selector(addAlien), userInfo: nil, repeats: true)
        
        bulletTimer = Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(fireBullets), userInfo: nil, repeats: true)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch: AnyObject in touches{
            player.position.x = touch.location(in: self).x
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch: AnyObject in touches{
            player.position.x = touch.location(in: self).x
        }
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        var firstBody:SKPhysicsBody
        var secondBody:SKPhysicsBody
        
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        }else{
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        
        if (firstBody.categoryBitMask & bulletCategory) != 0 && (secondBody.categoryBitMask & alienCategory) != 0 {
            bulletCollision(torpedoNode: firstBody.node as! SKSpriteNode, alienNode: secondBody.node as! SKSpriteNode)
        }
        
    }
    
    func bulletCollision (torpedoNode:SKSpriteNode, alienNode:SKSpriteNode) {
        
        let explosion = SKEmitterNode(fileNamed: "Explosion")!
        explosion.position = alienNode.position
        self.addChild(explosion)
        
        // self.run(SKAction.playSoundFileNamed("explosion.mp3", waitForCompletion: false))
        
        torpedoNode.removeFromParent()
        alienNode.removeFromParent()
        
        
        self.run(SKAction.wait(forDuration: 1)) {
            explosion.removeFromParent()
        }
        
        score += 5
        
        
    }
    
    @objc func addAlien () {
        possibleAliens = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: possibleAliens) as! [String]
        
        let alien = SKSpriteNode(imageNamed: possibleAliens[0])
        let min = self.size.width / 8
        let max = self.size.width - 20
        let point = UInt32(max-min)
        alien.position = CGPoint(x : CGFloat(arc4random_uniform(point)), y: self.size.height)
        
        let action = SKAction.moveTo(y: -(self.size.height / 2), duration: 3.0)
        alien.run(SKAction.repeatForever(action))
//        let randomAlienPosition = GKRandomDistribution(lowestValue: 0, highestValue: 414)
//        let position = CGFloat(randomAlienPosition.nextInt())
//
//        alien.position = CGPoint(x: position, y: self.frame.size.height + alien.size.height)

        alien.physicsBody = SKPhysicsBody(rectangleOf: alien.size)
        alien.physicsBody?.isDynamic = true
        
        alien.physicsBody?.categoryBitMask = alienCategory
        alien.physicsBody?.contactTestBitMask = bulletCategory
        alien.physicsBody?.collisionBitMask = 0
        
        self.addChild(alien)
        
        let animationDuration:TimeInterval = 6
        
        var actionArray = [SKAction]()
        
        
       //Tsel( actionArray.append(SKAction.move(to: CGPoint(x: position, y: -alien.size.height*20), duration: animationDuration))
      //  actionArray.append(SKAction.removeFromParent())
        
      //  alien.run(SKAction.sequence(actionArray))
        
        
    }
    
    @objc func fireBullets() {
        //self.run(SKAction.playSoundFileNamed("torpedo.mp3", waitForCompletion: false))
        
        let bullet = SKSpriteNode(imageNamed: "bullet")
        bullet.position = player.position
        bullet.position.y += 5
        
        bullet.physicsBody = SKPhysicsBody(circleOfRadius: bullet.size.width / 2)
        bullet.physicsBody?.isDynamic = true
        
        bullet.physicsBody?.categoryBitMask = bulletCategory
        bullet.physicsBody?.contactTestBitMask = alienCategory
        bullet.physicsBody?.collisionBitMask = 0
        bullet.physicsBody?.usesPreciseCollisionDetection = true
        
        self.addChild(bullet)
        
        let animationDuration:TimeInterval = 0.3
        
        
        var actionArray = [SKAction]()
        
        actionArray.append(SKAction.move(to: CGPoint(x: player.position.x, y: self.frame.size.height + 10), duration: animationDuration))
        actionArray.append(SKAction.removeFromParent())
        
        bullet.run(SKAction.sequence(actionArray))
    }
    
    override func update(_ currentTime: TimeInterval) {
        
    }
}
