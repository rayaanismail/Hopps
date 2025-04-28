//
//  ProgressionDistribution.swift
//  HoppsTestScene
//
//  Created by Rayaan Ismail on 4/26/25.
//

import Foundation
import SpriteKit

extension PlatformSystem {
    /// Applies multipliers from current stage to game data (distance, jump height, etc.)
    func distributeProgressionData() {
        platformDistance = config.platformDistance * currentStage.distanceMultiplier
        jumpVelocity = config.platformBounceVelocity * currentStage.jumpHeightMultiplier
    }
}
