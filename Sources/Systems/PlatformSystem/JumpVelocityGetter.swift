//
//  JumpVelocityGetter.swift
//  HoppsTestScene
//
//  Created by Rayaan Ismail on 5/1/25.
//

import Foundation
import SpriteKit

extension PlatformSystem {
    func fetchJumpVelocity() -> CGFloat {
        return jumpFactor * 2000
    }
}
