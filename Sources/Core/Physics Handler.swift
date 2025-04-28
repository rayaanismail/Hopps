//
//  Physics Handler.swift
//  HoppsTestScene
//
//  Created by Rayaan Ismail on 4/24/25.
//

import Foundation
import SpriteKit

extension GameScene {
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
        
        if firstBody.categoryBitMask == PhysicsCategory.character
            && secondBody.categoryBitMask == PhysicsCategory.bounce {
            firstBody.applyImpulse(CGVector(dx: 0, dy: platformSystem?.jumpVelocity ?? 200))
            
            }
        }
}
