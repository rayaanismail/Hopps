//
//  EnemySystem.swift
//  HoppsTestScene
//
//  Created by Analu Jahi on 5/2/25.
//

import SpriteKit

/// Configuration for EnemySystem
public struct EnemySystemConfig {
    public var maxEnemiesOnScreen: Int = 1      // Maximum simultaneous enemies
    public var spawnInterval: TimeInterval = 3.0   // Seconds between spawns
    public var chaseSpeed: CGFloat = 300.0         // Points per second

    /// Public initializer to allow default argument usage
    public init(maxEnemiesOnScreen: Int = 1,
                spawnInterval: TimeInterval = 3.0,
                chaseSpeed: CGFloat = 200.0) {
        self.maxEnemiesOnScreen = maxEnemiesOnScreen
        self.spawnInterval = spawnInterval
        self.chaseSpeed = chaseSpeed
    }
}

/// A system responsible for spawning, steering, and cleaning up enemies
class EnemySystem: SKNode, GameSystem {
    // MARK: - Properties
    private weak var sceneRef: SKScene?
    private weak var playerSystem: PlayerSystem?   // Used to fetch the player's character
    private var enemies: [SKSpriteNode] = []        // Active enemies
    private var timeSinceLastSpawn: TimeInterval = 0
    private let config: EnemySystemConfig
    private let enemySize = CGSize(width: 5, height: 5)

    // MARK: - Init
    init(playerSystem: PlayerSystem, config: EnemySystemConfig = EnemySystemConfig()) {
        self.playerSystem = playerSystem
        self.config = config
        super.init()
    }
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    // MARK: - Setup
    /// Adds this system into the scene; called from GameScene.didMove(to:)
    public func setup(in scene: SKScene) {
        sceneRef = scene
        scene.addChild(self)
    }

    // MARK: - Update Loop
    /// Called each frame from GameScene.update(_:) to drive spawning, steering, cleanup
    public func update(deltaTime: TimeInterval) {
        guard let scene = sceneRef else { return }
        // 1) Spawn new enemies if it's time
        print("enemyCount = \(enemies.count)")
        
        enemies.forEach {print($0.position)}
        timeSinceLastSpawn += deltaTime
        if timeSinceLastSpawn >= config.spawnInterval,
           enemies.count < config.maxEnemiesOnScreen {
            timeSinceLastSpawn = 0
            spawnEnemy(in: scene)
        }
        // 2) Steer existing enemies toward player character
        steerEnemies(dt: CGFloat(deltaTime))
        // 3) Remove offscreen enemies
    }

    // MARK: - Spawning
    private func spawnEnemy(in scene: SKScene) {
        // Spawn logic does not require playerSystem reference
        let enemy = SKSpriteNode(imageNamed: "birdEnemy")
        enemy.setScale(0.2)

        //  Determine camera-based spawn area
        // Ensure there'shave a GameScene to fetch camera position
        let gameScene = getScene()
        let camPos = gameScene.fetchCharacter().position
//        let halfW = scene.size.width  / 2
//        let halfH = scene.size.height / 2

        // Compute spawn coordinates based on camera view
        let spawnY = camPos.y + 50
        let leftX  = camPos.x - 50
        let rightX = camPos.x + 50 
        let spawnX = Bool.random() ? leftX : rightX
        enemy.position = CGPoint(x: spawnX, y: spawnY)
        print(("Enemy Spawn Position\(spawnX), \(spawnY)"))

        // Physics setup
        enemy.physicsBody = SKPhysicsBody(rectangleOf: enemySize)
        enemy.physicsBody?.isDynamic = false
        enemy.physicsBody?.categoryBitMask = PhysicsCategory.enemy   // defined in PhysicsCategory
        enemy.physicsBody?.contactTestBitMask = PhysicsCategory.character

        // Add to scene and track
        addChild(enemy)
        enemies.append(enemy)
    }

    // MARK: - Steering
    private func steerEnemies(dt: CGFloat) {
        // change to call player system
        let character = getScene().fetchCharacter()// Player's sprite
        let speed = config.chaseSpeed
        for enemy in enemies {
            let dx = character.position.x - enemy.position.x
            let dy = character.position.y - enemy.position.y
            let dist = hypot(dx, dy)
            guard dist < 1 else { continue }
            // Normalize and scale by chase speed
            let vx = dx / dist * speed
            let vy = dy / dist * speed
            enemy.position.x += vx * dt
            enemy.position.y += vy * dt
        }
    }

    // MARK: - Cleanup
//    private func cleanupEnemies(in scene: SKScene) {
//        for (index, enemy) in enemies.enumerated().reversed() {
//            if enemy.position.y < scene.frame.minY - enemySize.height {
//                enemy.removeFromParent()
//                enemies.remove(at: index)
//            }
//        }
//    }
}
