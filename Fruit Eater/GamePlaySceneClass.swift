//
//  GamePlaySceneClass.swift
//  Fruit Eater
//
//  Created by CS3714 on 1/18/17.
//  Copyright © 2017 Taiwen Jin. All rights reserved.
//

import UIKit
import SpriteKit

class GamePlaySceneClass: SKScene, SKPhysicsContactDelegate {
    private var player: Player?
    private var center = CGFloat();
    private var canMove = false
    private var moveLeft = false
    
    private var itemController = ItemController()
    private var scoreLabel:SKLabelNode?
    private var score = 0
    override func didMove(to view: SKView) {
        initializeGame()
    }
    
    private func initializeGame() {
        self.physicsWorld.contactDelegate = self
        player = childNode(withName: "Player") as? Player!
        player?.initializerPlayer()
        
        scoreLabel = self.childNode(withName: "ScoreLabel") as? SKLabelNode!
        scoreLabel?.text = "0"
        score = 0
        center = CGFloat(0)
        
        Timer.scheduledTimer(timeInterval: TimeInterval(itemController.randomBetweenNumbers(firstNum: 1,secondNum: 2)), target: self, selector: #selector(self.spawnItems), userInfo: nil, repeats: true)
        Timer.scheduledTimer(timeInterval: TimeInterval(7), target: self, selector: #selector(self.removeItems), userInfo: nil, repeats: true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            if location.x > center {
                moveLeft = false;
            } else {
                moveLeft = true;
            }
        }
        canMove = true
    }
    
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        canMove = false
    }
    
    private func managePlayer() {
        if canMove {
            player?.move(left: moveLeft)
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        managePlayer()
    }
    
    func spawnItems() {
        self.scene!.addChild(itemController.spawnItems())
    }
    func restartGame() {
        if let scene = GamePlaySceneClass(fileNamed:"GamePlayScene") {
            scene.scaleMode = .aspectFill
            
            // Present the scene
            view!.presentScene(scene, transition: SKTransition.doorsOpenHorizontal(withDuration: 2))
        }
    }
    func didBegin(_ contact: SKPhysicsContact) {
        var firstBody = SKPhysicsBody()
        var secondBody = SKPhysicsBody()
        if contact.bodyA.node?.name == "Player" {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        } else {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        
        if firstBody.node?.name == "Player" && secondBody.node?.name == "Fruit" {
            score += 1
            scoreLabel?.text = String(score)
            secondBody.node?.removeFromParent()
        }
        if firstBody.node?.name == "Player" && secondBody.node?.name == "Bomb" {
            firstBody.node?.removeFromParent()
            secondBody.node?.removeFromParent()
            
            Timer.scheduledTimer(timeInterval: TimeInterval(2), target: self, selector: #selector(self.restartGame), userInfo: nil, repeats: false)
        }
    }
    
    func removeItems() {
        for child in children {
            if child.name == "Fruit" || child.name == "Bomb" {
                if child.position.y < -self.scene!.frame.height - 100 {
                    child.removeFromParent()
                }
            }
        }
    }
}
