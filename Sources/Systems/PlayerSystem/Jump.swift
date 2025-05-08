//
//  InitialJump.swift
//  HoppsTestScene
//
//  Created by Rayaan Ismail on 5/7/25.
//

import Foundation
import SpriteKit

extension PlayerSystem {
    /// Applies a vertical impulse to the player with a magnitude of the given velocity
    func jump(velocity: CGFloat) {
        character.physicsBody?.applyImpulse(CGVector(dx: 0, dy: velocity))
    }
}
