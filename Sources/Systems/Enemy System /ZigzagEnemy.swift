//
//  ZigzagEnemy.swift
//  HoppsTestScene
//
//  Created by Analu Jahi on 5/19/25.
//

import SpriteKit

/// A zig-zagging enemy that oscillates horizontally or vertically within bounds.
final class ZigzagEnemy: EnemyProtocol {
    /// The sprite node representing this enemy.
    let node = SKSpriteNode(imageNamed: "RBirdEnemy")
    
    /// Distance (in points) the enemy moves per zig or zag.
    let zigzagDistance: CGFloat = 100
    
    /// Size used for physics body and position calculations.
    let enemySize = CGSize(width: 5, height: 5)

    /// Initializes the enemy, sets its scale, and configures physics.
    init() {
        node.setScale(0.2)
        configurePhysics()
    }

    /// Configures the physics body, category, and contact settings.
    func configurePhysics() {
        node.physicsBody = SKPhysicsBody(rectangleOf: enemySize)
        node.physicsBody?.isDynamic = false
        node.physicsBody?.categoryBitMask    = PhysicsCategory.enemy
        node.physicsBody?.contactTestBitMask = PhysicsCategory.character
    }

    /// Spawns the enemy at a world position and starts its zig-zag motion.
    /// - Parameters:
    ///   - position: The world coordinates to place the enemy.
    ///   - scene: The game scene (used to compute horizontal constraints).
    func spawn(at position: CGPoint, in scene: GameScene) {
        node.position = position
        constrainX(in: scene)    // Keep it within horizontal screen bounds
        startZigzag()            // Begin repeating zig-zag action
        print("🎉 Zigzag spawned at \(position)")
    }

    /// Per-frame update call (unused here—motion is driven by SKActions).
    func update(deltaTime: TimeInterval, in scene: GameScene) {
        // No-op: Zig-zag movement handled entirely by SKActions
    }

    /// Adds an SKConstraint so the node stays within the scene’s left/right edges.
    /// - Parameter scene: The GameScene used to calculate anchor positions.
    func constrainX(in scene: GameScene) {
        let minX = scene.anchorPosition(0, 0).x + enemySize.width / 2
        let maxX = scene.anchorPosition(1, 0).x - enemySize.width / 2
        node.constraints = [
            SKConstraint.positionX(
                SKRange(lowerLimit: minX, upperLimit: maxX)
            )
        ]
    }

    /// Constructs and runs the zig-zag SKAction sequence, repeating forever.
    func startZigzag() {
        let duration = Double.random(in: 1.5...3.0)
        let horizontal = Bool.random()
        let action: SKAction

        if horizontal {
            // Horizontal zig-zag: flip the sprite when changing direction
            let faceRight = SKAction.run { self.node.xScale = abs(self.node.xScale) }
            let faceLeft  = SKAction.run { self.node.xScale = -abs(self.node.xScale) }
            action = .sequence([
                faceRight,
                .moveBy(x: -zigzagDistance, y: 0, duration: duration),
                faceLeft,
                .moveBy(x: zigzagDistance, y: 0, duration: duration)
            ])
        } else {
            // Vertical zig-zag: move up then down
            let moveDown = SKAction.moveBy(x: 0, y: -zigzagDistance, duration: duration)
            let moveUp   = SKAction.moveBy(x: 0, y:  zigzagDistance, duration: duration)
            action = .sequence([moveDown, moveUp])
        }

        // Loop the action forever
        node.run(.repeatForever(action))
    }
}
