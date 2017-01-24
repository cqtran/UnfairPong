//
//  GameScene.swift
//  Pong
//
//  Created by Cameron Tran on 2017-01-23.
//  Copyright © 2017 Cameron Tran. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var ball = SKSpriteNode()
    var enemy = SKSpriteNode()
    var main = SKSpriteNode()

    override func didMove(to view: SKView) {
        ball = self.childNode(withName: "ball") as! SKSpriteNode
        enemy = self.childNode(withName: "enemy") as! SKSpriteNode
        main = self.childNode(withName: "main") as! SKSpriteNode
        
        // angle that ball shoots out at
        ball.physicsBody?.applyImpulse(CGVector(dx: 20, dy: 20))
        let border = SKPhysicsBody(edgeLoopFrom: self.frame)
        border.friction = 0
        border.restitution = 1
        
        self.physicsBody = border
        
        }
    // to make paddle go where finger is
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches{
            let location = touch.location(in: self) //grabs location of finger
            
            main.run(SKAction.moveTo(x: location.x, duration: 0.2))
            
            
        }
        
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches{
            let location = touch.location(in: self) //grabs location of finger
            
            main.run(SKAction.moveTo(x: location.x, duration: 0.2))
        }
    }
    override func update(_ currentTime: TimeInterval) {
        // decreasing duration will increase difficulty of enemy
        enemy.run(SKAction.moveTo(x: ball.position.x, duration: 1.0))
        // Called before each frame is rendered
    }
}
