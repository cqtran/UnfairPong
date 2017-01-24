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

    var score = [Int]()
    
    
    override func didMove(to view: SKView) {
        startGame()
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
    
    // to start game
    func startGame(){
        score = [0,0]
    }
    func addScore(playerWhoWon: SKSpriteNode){
        ball.position = CGPoint(x:0, y:0)
        ball.physicsBody?.velocity = CGVector(dx: 0 , dy: 0)
        
        
        if playerWhoWon == main{
            score[0] += 1
        }
        else if playerWhoWon == enemy{
            score[1] += 1
            ball.physicsBody?.applyImpulse(CGVector(dx: -20, dy: -20))
        }
        print(score)
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
        if ball.position.y <= main.position.y - 70 {
            addScore(playerWhoWon: enemy)
            
        }
        else if ball.position.y >= enemy.position.y + 70{
            addScore(playerWhoWon: main)
        }
        
        
        // Called before each frame is rendered
    }
}
