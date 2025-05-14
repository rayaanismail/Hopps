//
//  Physics Handler.swift
//  HoppsTestScene
//
//  Created by Rayaan Ismail on 4/24/25.
//

import Foundation
import SpriteKit

extension GameScene {
    func getJumpVelocity() -> CGFloat {
        platformSystem?.fetchJumpVelocity() ?? 0
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        var firstBody: SKPhysicsBody
        var secondBody: SKPhysicsBody
        
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        } else {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        
        // bounce logic
        if firstBody.categoryBitMask == PhysicsCategory.character
            && secondBody.categoryBitMask == PhysicsCategory.bounce {
            firstBody.velocity = CGVectorMake(0, 0)
            firstBody.applyImpulse(CGVector(dx: 0, dy: getJumpVelocity()))
            
        }
        
        // enemy collision: restart game
        if firstBody.categoryBitMask == PhysicsCategory.character
            && secondBody.categoryBitMask == PhysicsCategory.enemy {
            restart()
        }
    }
    
}

