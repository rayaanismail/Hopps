//
//  ZigzagEnemy.swift
//  HoppsTestScene
//
//  Created by Analu Jahi on 5/19/25.
//

enum ZigzagAnimationState {
    case gliding, floating
}

import SpriteKit

/// A zig-zagging enemy that can now oscillate horizontally, vertically, or diagonally.
final class ZigzagEnemy: EnemyProtocol {
    /// The sprite node representing this enemy.
    let node = SKSpriteNode(imageNamed: "RBirdEnemy")
    
    /// Distance (in points) the enemy moves per zig or zag.
    let zigzagDistance: CGFloat = 200
    
    /// Initializes the enemy, sets its scale, and configures physics.
    init() {
        node.setScale(0.3)
        node.yScale *= 1.7
        node.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        configurePhysics()
    }
    
    /// Configures the physics body, category, and contact settings.
    func configurePhysics() {
        node.physicsBody = SKPhysicsBody(rectangleOf: CGSize(
            width: node.size.width * 0.5,
            height: node.size.height * 0.1
        ))
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
        if scene.fetchAltitude() < 101000 {
            applyAnimation(for: .gliding)
        } else {
            node.setScale(0.2)
            node.yScale *= 1.7
            applyAnimation(for: .floating)
        }
        
        constrainX(in: scene)    // Keep within horizontal screen bounds
        startZigzag()            // Begin repeating zig-zag action
    }
    
    /// Per-frame update call (unused here—motion is driven by SKActions).
    func update(deltaTime: TimeInterval, in scene: GameScene) {
        // No-op: Zig-zag movement handled entirely by SKActions
    }
    
    /// Adds an SKConstraint so the node stays within the scene’s left/right edges.
    /// - Parameter scene: The GameScene used to calculate anchor positions.
    func constrainX(in scene: GameScene) {
        let minX = scene.anchorPosition(0, 0).x + node.size.width / 2
        let maxX = scene.anchorPosition(1, 0).x - node.size.width / 2
        node.constraints = [
            SKConstraint.positionX(
                SKRange(lowerLimit: minX, upperLimit: maxX)
            )
        ]
    }
    
    /// Constructs and runs the zig-zag SKAction sequence, repeating forever.
    /// Now includes a diagonal option in addition to horizontal/vertical.
    func startZigzag() {
        let duration = Double.random(in: 1.0...2.0)
        // 0 = horizontal, 1 = vertical, 2 = diagonal
        let directionIndex = Int.random(in: 0...2)
        let action: SKAction
        
        switch directionIndex {
        case 0:
            // Horizontal zig-zag: flip the sprite when changing direction
            let faceRight = SKAction.run { self.node.xScale = abs(self.node.xScale) }
            let faceLeft  = SKAction.run { self.node.xScale = -abs(self.node.xScale) }
            action = .sequence([
                faceRight,
                .moveBy(x: -zigzagDistance, y: 0, duration: duration),
                faceLeft,
                .moveBy(x: zigzagDistance, y: 0, duration: duration)
            ])
            
        case 1:
            //  Vertical zig-zag: move up then down
            let moveDown = SKAction.moveBy(x: 0, y: -zigzagDistance, duration: duration)
            let moveUp   = SKAction.moveBy(x: 0, y:  zigzagDistance, duration: duration)
            action = .sequence([moveDown, moveUp])
            
        case 2:
            //  Diagonal zig-zag: move down-left then up-right (or vice versa)
            // Choose randomly whether to start down-left/up-right or down-right/up-left
            let startDownLeft = Bool.random()
            if startDownLeft {
                let faceDownLeft  = SKAction.run {
                    self.node.xScale = abs(self.node.xScale)
                    // If you want to flip vertically, adjust yScale here; otherwise leave yScale positive
                }
                let faceUpRight   = SKAction.run {
                    self.node.xScale = -abs(self.node.xScale)
                }
                let moveDownLeft  = SKAction.moveBy(x: -zigzagDistance, y: -zigzagDistance, duration: duration)
                let moveUpRight   = SKAction.moveBy(x:  zigzagDistance, y:  zigzagDistance, duration: duration)
                action = .sequence([
                    faceDownLeft,
                    moveDownLeft,
                    faceUpRight,
                    moveUpRight
                ])
            } else {
                let faceDownRight = SKAction.run {
                    self.node.xScale = -abs(self.node.xScale)
                }
                let faceUpLeft    = SKAction.run {
                    self.node.xScale = abs(self.node.xScale)
                }
                let moveDownRight = SKAction.moveBy(x: zigzagDistance, y: -zigzagDistance, duration: duration)
                let moveUpLeft    = SKAction.moveBy(x: -zigzagDistance, y: zigzagDistance, duration: duration)
                action = .sequence([
                    faceDownRight,
                    moveDownRight,
                    faceUpLeft,
                    moveUpLeft
                ])
            }
            
        default:
            // Fallback to horizontal if something goes wrong
            let faceRight = SKAction.run { self.node.xScale = abs(self.node.xScale) }
            let faceLeft  = SKAction.run { self.node.xScale = -abs(self.node.xScale) }
            action = .sequence([
                faceRight,
                .moveBy(x: -zigzagDistance, y: 0, duration: duration),
                faceLeft,
                .moveBy(x: zigzagDistance, y: 0, duration: duration)
            ])
        }
        
        // Loop the action forever
        node.run(.repeatForever(action))
    }
    
    func applyAnimation(for state: ZigzagAnimationState) {
        node.removeAllActions()
        switch state {
        case .gliding:
            node.run(.repeatForever(AnimationManager.zigzagAnimation), withKey: "gliding")
        case .floating:
            node.run(.repeatForever(AnimationManager.alienAnimation), withKey: "floating")
        }
    }
    
    func convertToAlien() {
        node.run(.repeatForever(AnimationManager.alienAnimation), withKey: "floating")
        node.setScale(0.2)
        node.yScale *= 1.7
    }
}
