//
//  PlatformHandling.swift
//  HoppsTestScene
//
//  Created by Rayaan Ismail on 4/22/25.
//

import SpriteKit
import Foundation

extension PlatformSystem {
    func createPlatform(at position: CGPoint, type: PlatformStyle) {
        switch type {
        default:
            // Platform Sprite
            let platform = SKSpriteNode(imageNamed: "WPlatform1")
            platform.setScale(0.4)
            platform.position = position
            platform.zPosition = -1
            
            platform.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: platform.size.width, height: platform.size.height - 10))
            platform.physicsBody?.isDynamic = false
            platform.physicsBody?.categoryBitMask = PhysicsCategory.bounce
            platform.physicsBody?.contactTestBitMask = PhysicsCategory.character
            platform.physicsBody?.collisionBitMask = 0
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
            createPlatform(at: CGPoint(x: xPosition, y: yPosition), type: .stationary)
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
    
    func regeneratePlatforms() {
        guard let viewFrame = (scene as? GameScene)?.view?.frame else {return}
        guard let altitude = (scene as? GameScene)?.playerSystem?.altitude else {return}
        let width = viewFrame.width
        let margin = (-(width / 2) + platformWidth / 1.9, (width / 2) - platformWidth / 1.9)
        
        // If platform is below the player..
        for i in platforms.indices {
            if platforms[i].position.y < altitude - viewFrame.height {
//                print("platform at y: \(platforms[i].position.y) is \(viewFrame.height) below character at \(altitude)")
                
                // Move the platform to the very top
                let newY = lastPlatformY + platformDistance
                let newX = randomizeMargins(margin)
                platforms[i].position = CGPoint(x: newX, y: newY)
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
}
