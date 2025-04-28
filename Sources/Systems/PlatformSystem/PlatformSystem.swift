//
//  PlatformSystem.swift
//  HoppsTestScene
//
//  Created by Rayaan Ismail on 4/22/25.
//

import Foundation
import SpriteKit



class PlatformSystem: SKNode, GameSystem {
    private var groundPlatform: SKSpriteNode
    var config: PlatformConfig
    var platforms: [SKSpriteNode] = []
    var lastPlatformY: CGFloat = 50
    var lastBatchY: CGFloat = 0
    var platformWidth: CGFloat
    var platformDistance: CGFloat
    var platformBatch: Int
    
    var altitude: CGFloat {
        return (scene as? GameScene)?.playerSystem?.altitude ?? 0
    }
    
    let progressionManager: ProgressionManager = ProgressionManager()
    var jumpVelocity: CGFloat
    var currentStage: ProgressionStage
    /// The upper bound of the current stage, used to control when switching to next stage
    var nextStageBound: CGFloat
    
    init(_ config: PlatformConfig) {
        self.config = config
        groundPlatform = SKSpriteNode(color: .brown, size: CGSize(width: 500, height: 100))
        groundPlatform.position = CGPoint(x: 0, y: -400)
        groundPlatform.zPosition = 1
        groundPlatform.physicsBody = SKPhysicsBody(rectangleOf: groundPlatform.size)
        groundPlatform.physicsBody?.isDynamic = false
        groundPlatform.physicsBody?.restitution = 1.1
        
        platformWidth = config.platformWidth
        platformBatch = config.platformBatch
        // Spawn n number of platforms i distance apart with bounce triggers , off screen above the camera.
        currentStage = progressionManager.getCurrentStage(00)
        nextStageBound = currentStage.range.upperBound
        platformDistance = config.platformDistance * currentStage.distanceMultiplier
        jumpVelocity = config.platformBounceVelocity * currentStage.jumpHeightMultiplier
        super.init()
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func update(deltaTime: TimeInterval) {
        switchStage()
        updatePlatformPhysics()
        regeneratePlatforms()
        print("""
            Initial * modifier = Current Value
            \(config.platformDistance) * \(currentStage.distanceMultiplier) = \(platformDistance)
            \(config.platformBounceVelocity) * \(currentStage.jumpHeightMultiplier) = \(jumpVelocity)
            Current percentage of moving platforms: \(currentStage.movingPlatformChance)
            """)
    }
    
    func setup(in scene: SKScene) {
        scene.addChild(self)
        setupPlatforms(platformBatch, distance: platformDistance)
        addChild(groundPlatform)
        groundPlatform.position = CGPoint(x: 0, y: -scene.frame.height / 2 + groundPlatform.size.height / 2)
        platforms.forEach{addChild($0)}
        
    }
    
    
    
    
}


