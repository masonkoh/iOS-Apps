//
//  GameScene.swift
//  ShootingGameNew
//
//  Created by Fenil Shah on 2019-04-07.
//  Copyright © 2019 Pratik Ashokbhai Panchani, Youngmin Ko, Arnav Bansal. All rights reserved.
//

/*
 image source: https://www.google.com/imgres?imgurl=http%3A%2F%2Ffc02.deviantart.net%2Ffs71%2Ff%2F2013%2F164%2F8%2Fd%2Fvh3txd_by_turcuman-d68usui.png&imgrefurl=https%3A%2F%2Fwww.picsunday.com%2Fp%2FTop-of-a-Pirate-Ship.html&docid=WgUaJB_PZv04EM&tbnid=HdYxjuG1YJWseM%3A&vet=10ahUKEwjY6ubl2NLhAhUOjq0KHRQmBZ0QMwgpKAAwAA..i&w=233&h=446&safe=off&client=safari&bih=857&biw=1536&q=pirate%20png%20top%20view&ved=0ahUKEwjY6ubl2NLhAhUOjq0KHRQmBZ0QMwgpKAAwAA&iact=mrc&uact=8
 
 https://elderscrolls.fandom.com/wiki/Dragons_(Skyrim)
 */
/*
 sound source:
    Background music: written by Youngmin Mason Ko
    explosion: https://www.freesoundeffects.com/free-sounds/bomb-10076/
 */

import SpriteKit
import CoreMotion
import GameplayKit
import CoreData


class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var starfield:SKEmitterNode!
    var player:SKSpriteNode!
//    var viewController: GameViewController! // mknote temp
    
    var scoreLabel:SKLabelNode!
    var score:Int = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    var pauseScreen: SKSpriteNode!
    
    var gameTimer:Timer!
    var bulletTimer:Timer!
    var possibleAliens = ["alien1", "alien2", "alien3", "alien4", "alien5"]
    
    let alienCategory:UInt32 = 0x1 << 1
    let bulletCategory:UInt32 = 0x1 << 0
    let playerCategory: UInt32 = 0x1 << 2
    
    
    
    override func didMove(to view: SKView) {

        let background = SKSpriteNode(imageNamed: "background")
        background.position = CGPoint(x: 0, y: 0)
        background.zPosition = -2
        addChild(background)
        
        let backgroundSound = SKAudioNode(fileNamed: "bgm")
        self.addChild(backgroundSound)
        
        self.physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        self.physicsWorld.contactDelegate = self

        starfield = SKEmitterNode(fileNamed: "Starfield")
        starfield.position = CGPoint(x: 0, y: 1472)
        starfield.advanceSimulationTime(10)
        self.addChild(starfield)
        
        starfield.zPosition = -1
        
        player = SKSpriteNode(imageNamed: "spaceship")
        player.position = CGPoint(x: 0, y: (-self.size.height/3))
        player.physicsBody = SKPhysicsBody(rectangleOf: player.size)
        player.physicsBody?.isDynamic = true
        player.physicsBody?.affectedByGravity = false
        player.physicsBody?.mass = 1000000
        player.physicsBody?.categoryBitMask = playerCategory
        starfield.physicsBody?.contactTestBitMask = alienCategory
        //starfield.physicsBody?.collisionBitMask = 0

        self.addChild(player)
        

        
        scoreLabel = SKLabelNode(text: "Score: 0")
//        scoreLabel.position = CGPoint(x: (-size.width/2) + 200, y: self.frame.size.height/2 - 100)
        scoreLabel.position = CGPoint(x: (-size.width/2) + 200, y: self.frame.size.height/2 - 200)
        scoreLabel.fontName = "AmericanTypewriter-Bold"
        scoreLabel.fontSize = 36
        scoreLabel.fontColor = UIColor.white
        score = 0
        
        self.addChild(scoreLabel)
        
        pauseScreen = childNode(withName: "pauseScreen") as! SKSpriteNode
        pauseScreen.scale(to: CGSize(width: size.width, height: size.height))
        pauseScreen.isHidden = true
        
        startTimers()
        
        let recognizer = UIPinchGestureRecognizer(target: self, action: #selector(handlePinch))
        recognizer.location(in: self.view)
        self.view?.addGestureRecognizer(recognizer)
        
    }
    
    func startTimers() {
        gameTimer = Timer.scheduledTimer(timeInterval: 0.50, target: self, selector: #selector(addAlien), userInfo: nil, repeats: true)
        bulletTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(fireBullets), userInfo: nil, repeats: true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        for touch: AnyObject in touches{
//            player.position.x = touch.location(in: self).x
//        }
        let touch = touches.first
        if let location = touch?.location(in: self)
        {
            let theNodes = nodes(at: location)
            pauseScreen.isHidden = true
            //unPause()
            for node in theNodes
            {
                if node.name == "play"
                {
                    
                    score = 0
                    node.removeFromParent()
                    scene?.isPaused = false
                    gameTimer = Timer.scheduledTimer(timeInterval: 0.50, target: self, selector: #selector(addAlien), userInfo: nil, repeats: true)
                    
                    bulletTimer = Timer.scheduledTimer(timeInterval: 0.4, target: self, selector: #selector(fireBullets), userInfo: nil, repeats: true)
                    
                    
                }
            }
        }
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
        if contact.bodyA.categoryBitMask == playerCategory && contact.bodyB.categoryBitMask == alienCategory {
            gameOver()
        }
        
    }
    
    func bulletCollision (torpedoNode:SKSpriteNode, alienNode:SKSpriteNode) {
        
        let explosion = SKEmitterNode(fileNamed: "explosion")!
        explosion.position = alienNode.position
        self.addChild(explosion)
        
        self.run(SKAction.playSoundFileNamed("explosion", waitForCompletion: false))
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
//        let min = self.size.width / 8
//        let max = self.size.width - 20
//        let point = UInt32(max-min)
//        alien.position = CGPoint(x : CGFloat(arc4random_uniform(point)), y: self.size.height)
        alien.size = CGSize(width: 100, height: 100)
        let maxY = size.width / 2 - alien.size.width / 2
        let minY = -size.width / 2 + alien.size.width / 2
        let range = maxY - minY
        let coinY = maxY - CGFloat(arc4random_uniform(UInt32(range)))
        alien.position = CGPoint(x: coinY + 30, y: (size.height / 2 + alien.size.height / 2) - 30)
        
        let action = SKAction.moveTo(y: -(self.size.height / 2), duration: 3.0)
        alien.run(SKAction.repeatForever(action))
//        let randomAlienPosition = GKRandomDistribution(lowestValue: 0, highestValue: 414)
//        let position = CGFloat(randomAlienPosition.nextInt())
//
//        alien.position = CGPoint(x: position, y: self.frame.size.height + alien.size.height)

        alien.physicsBody = SKPhysicsBody(rectangleOf: alien.size)
        alien.physicsBody?.isDynamic = true
        
        alien.physicsBody?.categoryBitMask = alienCategory
        alien.physicsBody?.contactTestBitMask = bulletCategory | playerCategory
        alien.physicsBody?.collisionBitMask = 0
        
        self.addChild(alien)
        
        let animationDuration:TimeInterval = 6
        
        var actionArray = [SKAction]()
        
        // keeping node number same. remove corpse
        actionArray.append(SKAction.move(to: CGPoint(x: coinY + 30, y: -alien.size.height*20), duration: animationDuration))
        actionArray.append(SKAction.removeFromParent())
        alien.run(SKAction.sequence(actionArray))
    }
    
    @objc func fireBullets() {
//        self.run(SKAction.playSoundFileNamed("torpedo", waitForCompletion: false))
        
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
    
    @IBAction func handlePinch(recognizer : UIPinchGestureRecognizer) {
        print("The scale of the transform", recognizer.scale)
        if(recognizer.scale <= 1){
            pause()
        }
        else if (recognizer.scale > 1){
            unPause()
        }
        //recognizer.scale = 1
    }
    
    func pause(){
        for node in self.children {
            node.isPaused = true
            pauseScreen.isHidden = false
            if(bulletTimer.isValid){
                bulletTimer.invalidate()
            }
            if(gameTimer.isValid){
                gameTimer.invalidate()
            }
        }
    }
    
    func unPause(){
        for node in self.children {
            node.isPaused = false
            pauseScreen.isHidden = true
            if(!bulletTimer.isValid && !gameTimer.isValid){
                startTimers()
            }
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        
    }
    func gameOver() {
        
        scene?.isPaused = true
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "UserData")
        request.returnsObjectsAsFaults = false
        
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                if(data.value(forKey: "score") as! Int32 == -1)
                {
                    data.setValue(score, forKey: "score")
                    
                    do{
                        try context.save()
                    }
                    catch {
                        print("E from gameOver()")
                    }
                    
                }
                else
                {
                    print("Error")
                }
            }
            
        } catch {
            
            print("Error")
        }
        bulletTimer?.invalidate()
        gameTimer?.invalidate()
        
        let playButton = SKSpriteNode(imageNamed: "play")
        playButton.position = CGPoint(x: 0, y: -200)
        playButton.name = "play"
        playButton.zPosition = 1
        addChild(playButton)
    }
}
