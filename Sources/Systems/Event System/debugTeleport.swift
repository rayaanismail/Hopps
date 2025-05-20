//
//  debugTeleport.swift
//  HoppsTestScene
//
//  Created by Rayaan Ismail on 5/15/25.
//

import Foundation
import SpriteKit
extension EventSystem {
    func debugTeleport(y: CGFloat, yForce: CGFloat) {
        let character = getScene().fetchCharacter()
        
        character.position = CGPoint(x: 0, y: y)
        character.physicsBody?.applyImpulse(CGVector(dx: 0, dy: yForce))
    }
}

