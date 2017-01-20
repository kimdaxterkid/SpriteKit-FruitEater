//
//  MainMenuScene.swift
//  Fruit Eater
//
//  Created by CS3714 on 1/18/17.
//  Copyright © 2017 Taiwen Jin. All rights reserved.
//

import UIKit
import SpriteKit

class MainMenuScene: SKScene {
    
    override func didMove(to view: SKView) {
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            
            if atPoint(location).name == "Start" {
                if let scene = GamePlaySceneClass(fileNamed: "GamePlayScene") {
                    // Set the scale mode to scale to fit the window
                    scene.scaleMode = .aspectFill
                    
                    // Present the scene
                    view!.presentScene(scene, transition: SKTransition.doorsOpenVertical(withDuration: 2))
                }
            }
            
            
            
        }
    }
}
