//
//  DistributeStage.swift
//  HoppsTestScene
//
//  Created by Rayaan Ismail on 4/29/25.
//

import Foundation
import SpriteKit

extension PlatformSystem {
    /// Retrieves altitude, and distributes all data for the stage accross the platform system
    func distributeStage() {
        let altitude = getAltitude()
        
        if altitude > progressionManager.currentStageUpperBound {
            progressionManager.setCurrentStage(altitude)
            jumpVelocity = progressionManager.currentStage.jumpHeightMultiplier * config.jumpVelocity
            platformDistance = progressionManager.currentStage.distanceMultiplier * config.platformDistance
        } else {
            return
        }
        
        
    }
}
