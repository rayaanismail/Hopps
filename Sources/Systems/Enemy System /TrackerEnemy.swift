//
//  TrackerEnemy.swift
//  HoppsTestScene
//
//  Created by Analu Jahi on 5/19/25.
//

//import SpriteKit
//
//
//enum TrackerAnimationState {
//    case flying
//}
//
///// A "smart" tracker enemy that homes in on the player and tilts smoothly.
//final class TrackerEnemy: EnemyProtocol {
//    /// The sprite node representing the tracker bird.
//    let node = SKSpriteNode(imageNamed: "EBirdEnemy")
//
//    /// Maximum movement speed (points per second).
//    let chaseSpeed: CGFloat = 300
//
//    /// Interpolation factor for smoothing rotation.
//    let tiltSmoothing: CGFloat = 0.125
//
//    /// Size used for physics body and horizontal clamping.
//    let enemySize = CGSize(width: 5, height: 5)
//
//    /// Initializes the tracker: sets scale and physics configuration.
//    init() {
//        node.setScale(1.4)
//        configurePhysics()
//    }
//
//    /// Configures physics body, collision mask, and contact mask.
//    func configurePhysics() {
//        node.physicsBody = SKPhysicsBody(rectangleOf: enemySize)
//        node.physicsBody?.isDynamic = false
//        node.physicsBody?.categoryBitMask    = PhysicsCategory.enemy
//        node.physicsBody?.contactTestBitMask = PhysicsCategory.character
//    }
//
//    /// Spawns the tracker at a world position.
//    /// - Parameter position: World coordinates where the tracker appears.
//    func spawn(at position: CGPoint) {
//        node.position = position
//        applyAnimation(for: .flying)
//    }
//
//    /// Called each frame: moves, rotates, and clamps horizontal position.
//    /// - Parameters:
//    ///   - deltaTime: Time elapsed since last frame.
//    ///   - scene: The GameScene, used to fetch player and bounds.
//    func update(deltaTime: TimeInterval, in scene: GameScene) {
//        // 1) Get the player character
//        guard let character = scene.fetchCharacter() as? SKSpriteNode else { return }
//
//        // 2) Move toward the player
//        let dt = CGFloat(deltaTime)
//
//        chase(character: character, dt: dt)
//        
//        // 3) Rotate smoothly to face the player
//        rotateToward(character)
//
//        // 4) Keep within horizontal screen bounds
//        clampPosition(in: scene)
//    }
//
//    /// Moves the tracker a small step toward the character.
//    /// - Parameters:
//    ///   - character: The player node to chase.
//    ///   - dt: Delta time in seconds.
//    func chase(character: SKSpriteNode, dt: CGFloat) {
//        let dx = character.position.x - node.position.x
//        let dy = character.position.y - node.position.y
//        let distance = hypot(dx, dy)
//        guard distance > 0 else { return }
//
//        // Compute step size (do not overshoot)
//        let step = min(distance, chaseSpeed * dt)
//        node.position.x += dx / distance * step
//        node.position.y += dy / distance * step
//    }
//
//    /// Smoothly rotates the tracker to face the character.
//    /// - Parameter character: The player node to face.
//    func rotateToward(_ character: SKSpriteNode) {
//        let dx = character.position.x - node.position.x
//        let dy = character.position.y - node.position.y
//        // Base angle (art faces right by default); add π to flip if needed
//        let targetAngle = atan2(dy, dx) + .pi
//
//        // Interpolate from current rotation to target for smooth motion
//        let current = node.zRotation
//        node.zRotation = current + (targetAngle - current) 
//    }
//
//    /// Clamps the tracker’s x-position within the scene's horizontal bounds.
//    /// - Parameter scene: The GameScene providing anchorPosition.
//    func clampPosition(in scene: GameScene) {
//        let halfW = enemySize.width / 2
//        let leftEdge  = scene.anchorPosition(0, 0).x + halfW
//        let rightEdge = scene.anchorPosition(1, 0).x - halfW
//        node.position.x = min(max(node.position.x, leftEdge), rightEdge)
//    }
//    
//    func applyAnimation(for state: TrackerAnimationState) {
//        node.removeAllActions()
//        switch state {
//        case .flying:
//            node.run(.repeatForever(AnimationManager.trackerAnimation), withKey: "flying")
//        }
//    }
//    
//}
