//
//  debugTeleport.swift
//  HoppsTestScene
//
//  Created by Rayaan Ismail on 5/15/25.
//

import Foundation
import SpriteKit
extension EventSystem {
    enum DebugState {
        case on, off
    }
    
    func debugTeleport(y: CGFloat, yForce: CGFloat, debugState: DebugState) {
        let characterY: CGFloat = getScene().fetchCharacter().position.y
        if characterY < y && debugState == .on {
            let character = getScene().fetchCharacter()
            
            character.position = CGPoint(x: character.position.x, y: y)
            character.physicsBody?.applyImpulse(CGVector(dx: 0, dy: yForce))
        }
        
    }
}

