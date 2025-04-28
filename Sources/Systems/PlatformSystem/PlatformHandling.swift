//
//  PlatformHandling.swift
//  HoppsTestScene
//
//  Created by Rayaan Ismail on 4/22/25.
//

import SpriteKit
import Foundation

extension PlatformSystem {
    func createPlatform(at position: CGPoint, type: PlatformStyle) { /// Subject to change
        guard let viewFrame = (scene as? GameScene)?.view?.frame else {return}
        let width = viewFrame.width
        let margin = (-(width / 2) + platformWidth / 1.9, (width / 2) - platformWidth / 1.9)
        
        switch type {
        default:
            // Platform Sprite
            var platform = SKSpriteNode(imageNamed: "WPlatform1")
            platform.setScale(0.4)
            platform.position = position
            platform.zPosition = -1
            
            platform.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: platform.size.width, height: platform.size.height - 10))
            platform.physicsBody?.isDynamic = false
            platform.physicsBody?.categoryBitMask = PhysicsCategory.bounce
            platform.physicsBody?.contactTestBitMask = PhysicsCategory.character
            platform.physicsBody?.collisionBitMask = 0
            
            configure(&platform, to: type, margins: margin)
            platforms.append(platform)
            lastPlatformY = max(lastPlatformY, position.y)
            
            
        }
    }
    
    func setupPlatforms(_ amount: Int = 10, distance: CGFloat = 250) {
        let topY = lastPlatformY
        let width = (scene as? GameScene)?.view?.frame.width ?? 0
        let margin = (-(width / 2) + platformWidth / 1.9, (width / 2) - platformWidth / 1.9)
        // MARK: TODO
        for i in 0..<amount {
            let yPosition = (topY) + CGFloat(i) * distance
            let xPosition = CGFloat.random(in: margin.0...margin.1)
            createPlatform(at: CGPoint(x: xPosition, y: yPosition), type: getPlatformType())
        }
        lastBatchY = lastPlatformY
    }
    
    func updatePlatformPhysics() {
        for platform in platforms {
            guard let character = (scene as? GameScene)?.playerSystem?.character else {return}
            let platformBottom = platform.position.y
            let characterTop = character.position.y - (character.size.height / 2) + 10
            if characterTop < platformBottom {
                platform.physicsBody = nil
            } else {
                if platform.physicsBody == nil {
                    platform.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: platform.size.width, height: platform.size.height - 10))
                    platform.physicsBody?.isDynamic = false
                    platform.physicsBody?.categoryBitMask = PhysicsCategory.bounce
                    platform.physicsBody?.contactTestBitMask = PhysicsCategory.character
                    platform.physicsBody?.collisionBitMask = 0
                
                }
            }
        }
    }
    
    func regeneratePlatforms() { /// Subject to change
        guard let viewFrame = (scene as? GameScene)?.view?.frame else {return}
        guard let altitude = (scene as? GameScene)?.playerSystem?.altitude else {return}
        let width = viewFrame.width
        let margin = (-(width / 2) + platformWidth / 1.9, (width / 2) - platformWidth / 1.9)
        
        // If platform is below the player..
        for i in platforms.indices {
            if platforms[i].position.y < altitude - viewFrame.height {
                
                // Move the platform to the very top
                let newY = lastPlatformY + platformDistance
                let newX = randomizeMargins(margin)
                
                platforms[i].position = CGPoint(x: newX, y: newY)
                configure(&platforms[i], to: getPlatformType(), margins: margin)
                lastPlatformY = newY
            }
        }
    }
    
    func randomizeMargins(_ input: (CGFloat, CGFloat)) -> CGFloat{
        // Randomizes by returning a shuffled and sometimes flipped value
        var randomizedArray = [CGFloat]()
        let changeNegative = Bool.random()
        for _ in 0...3 {
            randomizedArray.append(CGFloat.random(in: input.0...input.1))
        }
        let chosenNum = randomizedArray.randomElement()
        return changeNegative ? (-chosenNum!) : chosenNum!
    }
    
    /// Changes platform behavior based on its style
    func configure(_ platform: inout SKSpriteNode, to type: PlatformStyle, speed: Double = 1, margins: (CGFloat, CGFloat)) {
        let travelDistance = abs(margins.0 - margins.1) /// Returns travelable distance across the screen
        let mR = SKAction.moveBy(x: travelDistance, y: 0, duration: speed)
        let mL = SKAction.moveBy(x: -travelDistance, y: 0, duration: speed)
        
        
        switch type {
        case .stationary:
            platform.removeAllActions()
            return
            
        case .moving:
            platform.removeAllActions()
            let movingRight: Bool = Bool.random()
            platform.position.x = movingRight ? margins.0 : margins.1
            
            if movingRight { /// Starting on left side, move right THEN left forever
                let sequence = SKAction.sequence([mR, mL])
                let repeating = SKAction.repeatForever(sequence)
                platform.run(repeating)
            } else { /// Starting on right side, move left then right forever
                let sequence = SKAction.sequence([mL, mR])
                let repeating = SKAction.repeatForever(sequence)
                platform.run(repeating)
            }
        default:
            return
        }
    }
    /// Returns platform type based on current stage chances
    func getPlatformType() -> PlatformStyle{
        if currentStage.platformDistribution.isEmpty {
            return .stationary
        }
        
        // Random CGFloat that decides what type of platform will spawn given the current stage settings
        let decision = CGFloat.random(in: 0...1)
        var stationaryChance: CGFloat = 0
        
        for distribution in currentStage.platformDistribution {
            if distribution.style == .stationary {
                stationaryChance = distribution.percentage
            }
        }
        
        /// Change this logic if deciding to add more platforms
        if decision < stationaryChance {
            return .stationary
        } else {
            return .moving
        }
    }
    
    /// Switches to the next stage by checking if the current altitude is greater than the upper altitude bound of the current stage
    func switchStage() {
        if altitude > nextStageBound {
            currentStage = progressionManager.getCurrentStage(altitude + 1)
            distributeProgressionData()
        }
    }
}

