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
    var platforms: [SKSpriteNode] = []
    var lastPlatformY: CGFloat = 50
    var lastBatchY: CGFloat = 0
    var platformWidth: CGFloat
    var platformDistance: CGFloat
    var platformBatch: Int
    
    init(_ config: PlatformConfig) {
        groundPlatform = SKSpriteNode(color: .brown, size: CGSize(width: 500, height: 100))
        groundPlatform.position = CGPoint(x: 0, y: -400)
        groundPlatform.zPosition = 1
        groundPlatform.physicsBody = SKPhysicsBody(rectangleOf: groundPlatform.size)
        groundPlatform.physicsBody?.isDynamic = false
        groundPlatform.physicsBody?.restitution = 1.1
        
        platformWidth = config.platformWidth
        platformDistance = config.platformDistance
        platformBatch = config.platformBatch
        // Spawn n number of platforms i distance apart with bounce triggers , off screen above the camera.
        
        super.init()
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func update(deltaTime: TimeInterval) {
        updatePlatformPhysics()
        regeneratePlatforms()
    }
    
    func setup(in scene: SKScene) {
        scene.addChild(self)
        setupPlatforms(platformBatch, distance: platformDistance)
        addChild(groundPlatform)
        groundPlatform.position = CGPoint(x: 0, y: -scene.frame.height / 2 + groundPlatform.size.height / 2)
        platforms.forEach{addChild($0)}
    }
    
    
    
    
}


