//
//  EventSystem.swift
//  HoppsTestScene
//
//  Created by Rayaan Ismail on 5/7/25.
//

import Foundation
import SpriteKit

struct EventConfig {
    
}

/// Handles all events, checking each update loop and certain conditions to trigger.
class EventSystem: SKNode, GameSystem {
    /// Time data from the parent scene
    var timeData: GameTime {
        getScene().gameTime
    }
    var cage: SKSpriteNode
    
    func update(deltaTime: TimeInterval) {
        if timeData.elapsedTime == 0 {
            startGame()
        }
    }
    
    func setup(in scene: SKScene) {
        addChild(cage)
        scene.addChild(self)
    }
    
    init(config: EventConfig) {
        cage = SKSpriteNode(texture: AnimationManager.cageTexture)
        cage.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        cage.zPosition = 10
        cage.alpha = 0
        cage.setScale(2)
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
