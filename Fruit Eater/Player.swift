//
//  Player.swift
//  Fruit Eater
//
//  Created by CS3714 on 1/19/17.
//  Copyright © 2017 Taiwen Jin. All rights reserved.
//

import UIKit
import SpriteKit

class Player: SKSpriteNode {
    private let minX = CGFloat(-200)
    private let maxX = CGFloat(200)
    func initializerPlayer() {
        self.name = "Player"
        self.physicsBody = SKPhysicsBody(circleOfRadius: self.size.height / 2)
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.isDynamic = false
        self.physicsBody?.categoryBitMask = ColliderType.PLAYER
        self.physicsBody?.contactTestBitMask = ColliderType.FRUIT_AND_BOMB
    }
    func move(left: Bool) {
        if left {
            if self.position.x > minX {
                self.position.x -= 15
            }
        } else {
            if self.position.x < maxX {
                self.position.x += 15
            }
        }
    }
}
