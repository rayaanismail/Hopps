//
//  SetupPlatformData.swift
//  HoppsTestScene
//
//  Created by Rayaan Ismail on 4/29/25.
//

import Foundation
import SpriteKit

extension PlatformSystem {
    
    /// Updates the physics bodies of the platforms so that they are able to be both passed through and jumped on
    func updatePlatformPhysics() {
        for i in platforms.indices {
            let platform = platforms[i]
            let platformBottom = platforms[i].position.y
            let playerMid = getCharacter().position.y - getCharacter().frame.height / 3
            
            
            if playerMid < platformBottom {
                platform.physicsBody = nil
            } else {
                // MARK: Edit this to adjust hitbox
                let platformHitboxSize = CGSize(width: platform.size.width, height: platform.size.height * 0.3)
                platform.physicsBody = SKPhysicsBody(rectangleOf: platformHitboxSize)
                platform.physicsBody?.isDynamic = false
                platform.physicsBody?.categoryBitMask = PhysicsCategory.bounce
                platform.physicsBody?.contactTestBitMask = PhysicsCategory.character
                platform.physicsBody?.collisionBitMask = 0
                
            }
            
            
        }
    }
    
    
    
}
