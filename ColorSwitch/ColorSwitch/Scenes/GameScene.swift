//
//  GameScene.swift
//  ColorSwitch
//
//  Created by Mason Ko on 2019-02-19.
//  Copyright © 2019 Mason Ko. All rights reserved.
//

import SpriteKit

enum PlayColors{
    static let colors = [
        UIColor(red: 231/255, green: 76/255, blue: 60/255, alpha: 1.0),
        UIColor(red: 241/255, green: 196/255, blue: 15/255, alpha: 1.0),
        UIColor(red: 46/255, green: 204/255, blue: 113/255, alpha: 1.0),
        UIColor(red: 52/255, green: 152/255, blue: 219/255, alpha: 1.0)
    ]
}
enum SwitchState: Int{
    case red, yellow, green, blue;
}


class GameScene: SKScene {
    
    var colorSwitch: SKSpriteNode!;
    var switchState = SwitchState.red; // initial color will be red
    var currentColorIndex:  Int?;
    
    override func didMove(to view: SKView) {
        setupPhysics();
        layoutScene();
    }
    
    func setupPhysics(){
        physicsWorld.gravity = CGVector(dx: 0.0, dy: -2.0)
        physicsWorld.contactDelegate = self
    }
    
    func layoutScene() {
        backgroundColor = UIColor(red: 44/255, green: 62/255, blue: 80/255, alpha: 1.0);
        
        colorSwitch = SKSpriteNode(imageNamed: "ColorCircle");
        colorSwitch.size = CGSize(width: frame.size.width/3, height: frame.size.width/3);
        colorSwitch.position = CGPoint(x: frame.midX, y: frame.minY + colorSwitch.size.height);
        colorSwitch.physicsBody = SKPhysicsBody(circleOfRadius: colorSwitch.size.width/2);
        colorSwitch.physicsBody?.categoryBitMask = PhysicsCategories.switchCategory;
        colorSwitch.physicsBody?.isDynamic = false;
        
        addChild(colorSwitch);
        
        spawnBall();
    }
    
    func spawnBall(){
        currentColorIndex = Int.random(in: 0...3);
        print(currentColorIndex); // debug purpose
        
        let ball = SKSpriteNode(texture: SKTexture(imageNamed: "ball"), color: PlayColors.colors[currentColorIndex!], size: CGSize(width: 30.0, height: 30.0));
        
        ball.colorBlendFactor = 1.0;
        ball.name = "ball";
        ball.position = CGPoint(x: frame.midX, y: frame.maxY - 50);
        ball.physicsBody = SKPhysicsBody(circleOfRadius: ball.size.width/2);
        ball.physicsBody?.categoryBitMask = PhysicsCategories.ballCategory;
        ball.physicsBody?.contactTestBitMask = PhysicsCategories.switchCategory;
        ball.physicsBody?.collisionBitMask = PhysicsCategories.none;
        
        addChild(ball);
    }
    
    func turnWheel(){
        if let newState = SwitchState(rawValue: switchState.rawValue + 1){
            switchState = newState;
        } else {
            switchState = .red;
        }
        colorSwitch.run(SKAction.rotate(byAngle: .pi/2, duration: 0.25))
    }
    
    func gameOver(){
        print("GameOver!");
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        turnWheel();
    }
    
}

extension GameScene: SKPhysicsContactDelegate {
    func didBegin(_ contact: SKPhysicsContact) {
        // let's remember how we define our bit masks.
        // 01
        // 10
        // 11
        let contactMask = contact.bodyA.categoryBitMask |
            contact.bodyB.categoryBitMask
        
        if contactMask == PhysicsCategories.ballCategory | PhysicsCategories.switchCategory{
            if let ball = contact.bodyA.node?.name == "ball" ? contact.bodyA.node as? SKSpriteNode : contact.bodyB.node as? SKSpriteNode {
                if currentColorIndex == switchState.rawValue{
                    print("correct!");
                    ball.run(SKAction.fadeOut(withDuration: 0.25), completion: {
                        ball.removeFromParent()
                        self.spawnBall()
                    })
                } else {
                    gameOver();
                }
            }
        }
    }
}
