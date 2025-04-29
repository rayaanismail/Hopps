//
//  SetupPlatformData.swift
//  HoppsTestScene
//
//  Created by Rayaan Ismail on 4/29/25.
//

import Foundation
import SpriteKit

extension PlatformSystem {
    
    /// Transforms the given platform to have the attributes associated to a platform type. The chance is processed by the progression manager, and the speed is set through the config.
    func configure(_ platform: inout SKSpriteNode) {
        // MARK: Could also configure speed of platforms
        // Assign platform a type based on current progression
        let type = progressionManager.currentStage.weightedRandomStyle()
        let platformY = platform.position.y
        let mR = SKAction.move(to: CGPoint(x: margin.upper, y: platformY), duration: config.platformMoveSpeed)
        let mL = SKAction.move(to: CGPoint(x: margin.lower, y: platformY), duration: config.platformMoveSpeed)
        
        
        switch type {
        case .stationary:
            platform.removeAllActions()
            return
        case .moving:
            let movingRight = Bool.random()
            if movingRight {
                let sequence = SKAction.sequence([mR, mL])
                let repeating = SKAction.repeatForever(sequence)
                platform.run(repeating)
            } else {
                let sequence = SKAction.sequence([mL, mR])
                let repeating = SKAction.repeatForever(sequence)
                platform.run(repeating)
            }
            return
        default:
            platform.removeAllActions()
            return
        }
    }
}
