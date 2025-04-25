//
//  GameScene.swift
//  HoppsTestScene
//
//  Created by Rayaan Ismail on 4/18/25.
//

import Foundation
import SpriteKit

class GameScene: SKScene {
    
}

protocol GameSystem {
    func update(deltaTime: TimeInterval)
    func setup(in scene: SKScene)
}
