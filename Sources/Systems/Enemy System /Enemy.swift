
//
//  Enemy.swift
//  HoppsTestScene
//
//  Created by Analu Jahi on 5/19/25.
//

import SpriteKit

/// Common protocol for all enemy types
protocol EnemyProtocol {
    /// The SKSpriteNode to add to the scene
    var node: SKSpriteNode { get }

    /// Per-frame update call
    func update(deltaTime: TimeInterval, in scene: GameScene)
}
