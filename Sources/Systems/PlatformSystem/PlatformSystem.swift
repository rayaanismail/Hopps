//
//  PlatformSystem.swift
//  HoppsTestScene
//
//  Created by Rayaan Ismail on 4/22/25.
//

import Foundation
import SpriteKit


/// Handles the spawning, arranging, and managing of the platforms within the gamescene
class PlatformSystem: SKNode, GameSystem {
    var floorPlatform: SKSpriteNode
    var progressionManager: ProgressionManager
    var config: PlatformConfig
    
    var platforms: [SKSpriteNode] = [SKSpriteNode]()
    
    var lastPlatformY: CGFloat = 0
    var spawnThresholdY: CGFloat {
        (lastPlatformY - getView().frame.height - 200)
    }
    var width: CGFloat = 0
    var margin: (lower: CGFloat, upper: CGFloat) = (0, 0)
    
    /// The factor of which the jump velocity is derived, it is calculated by the platform distance multiplied by a factor. The character by default will jump f * platform distance.
    var jumpFactor: CGFloat
    var platformDistance: CGFloat
    var platformCounter: CGFloat = 0
    
    init(_ config: PlatformConfig) {
        self.config = config
        floorPlatform = SKSpriteNode()
        progressionManager = ProgressionManager()
        progressionManager.setCurrentStage(0) /// Sets the current stage and upper bound
        
        // Initialize jump velocity and distance multipliers
        platformDistance = progressionManager.currentStage.distanceMultiplier * config.platformDistance
        jumpFactor = (progressionManager.currentStage.jumpHeightMultiplier)
        
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func update(deltaTime: TimeInterval) {
        distributeStage()
        maintainPlatforms()
        
    }
    
    func setup(in scene: SKScene) {
        scene.addChild(self)
        setupGroundPlatform(scene)
        setupPlatformData()
        addChild(floorPlatform)
        
    }
    
    func setupGroundPlatform(_ scene: SKScene) {
        floorPlatform = SKSpriteNode(imageNamed: "FloorPlatform")
        /// Positioned in the middle of the screen, slightly below the zero
        floorPlatform.position = getScene().anchorPosition(0.5, 0.05)
        floorPlatform.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: floorPlatform.size.width, height: floorPlatform.size.height * 0.3))
        floorPlatform.setScale(0.5)
        floorPlatform.zPosition = -10
        floorPlatform.physicsBody?.isDynamic = false
    }
    
    
}


