//
//  MaintainPlatforms.swift
//  HoppsTestScene
//
//  Created by Rayaan Ismail on 4/29/25.
//

import Foundation
import SpriteKit

extension PlatformSystem {
    /// Creates initial platforms based on platform data, stage data, and config data
    func setupPlatforms() {
        for i in 0..<config.platformBatch {
            createPlatform(at: randomPosition(index: i, setup: true))
        }
    }
    /// Creates a platform at a given y position, applying the current stages texture for that y position
    func createPlatform(at point: CGPoint) {
        let imageName = progressionManager.currentStage.randomTexture
        var platform = SKSpriteNode(imageNamed: imageName)
        platform.setScale(config.platformScale)
        platform.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        platform.position = point
        platform.zPosition = -1
        
        // Configure platform for stage & type
        addChild(platform)
        configure(&platform)
        platforms.append(platform)
        lastPlatformY = point.y
    }
    
    
    
    /// Creats platforms if there are none, manages the respawning & changing of platforms
    func maintainPlatforms() {
        /// The y position of the last platform, subtracted by the viewing device
        let spawnThresholdY = (lastPlatformY - getView().frame.height - 200)
        if platforms.isEmpty {
            setupPlatforms()
            
            
        }
        
        updatePlatformPhysics()
        /// Else if player.y is half height under platformY cycle through indexes with a counter.
        if getCamera().position.y > spawnThresholdY {
            // MARK: Regenerate Platforms
            regeneratePlatforms()
            
        }
    }

    /// Uses clever-ish logic to programattically move platforms above each other outside of hte players view, as to make it seem like the platforms are spawning infinitely, while being memory efficient.
    func regeneratePlatforms() {
        let characterY = getCharacter().position.y
        let viewHeight = getView().frame.height
        
        // Find the current highest platform Y-position in the array
        var highestPlatformY = platforms.map { $0.position.y }.max() ?? 0
        
        // Loops through the platforms
        for i in platforms.indices {
            var platform = platforms[i]
//            platform.size = CGSize(width: 100, height: 50)
            
            // If platforms are below the player...
            if platform.position.y < characterY - viewHeight {
                // New Y-position is above the highest existing platform
                
                let newY = highestPlatformY + platformDistance
                var point = randomPosition(index: i) /// Reuse the random alternating x, but not the y
                point.y = newY
                platform.removeAllActions()
                platform.position = point
                let randomTexture = SKTexture(imageNamed: progressionManager.currentStage.randomTexture)
                platform.texture = randomTexture
                
                // Inside the loop, update for the next platform in the array
                highestPlatformY += config.platformDistance
                configure(&platform)
                
            }
        }
    }
}
