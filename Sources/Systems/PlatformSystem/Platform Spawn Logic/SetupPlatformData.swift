//
//  SetupPlatformData.swift
//  HoppsTestScene
//
//  Created by Rayaan Ismail on 4/29/25.
//

import Foundation
import SpriteKit

extension PlatformSystem {
    /// Initializes the data that the platform generation system uses
    func setupPlatformData() {
        let halfWidth = getView().halfWidth()
        
        lastPlatformY = 0
        width = getView().frame.width
        margin = (
            lower: -halfWidth * config.marginPercentage,
            upper: halfWidth * config.marginPercentage
        )
    }
    /// Resets platform data, relies on camera / player position, reset after applying the start event
    func resetPlatformData() {
        // Resets platform compute data
        setupPlatformData()
        
        // Reset currentStage, apply jump and distance multiplier
        let altitude = getAltitude()
        progressionManager.setCurrentStage(altitude)
        let stage = progressionManager.currentStage
        jumpFactor = stage.jumpHeightMultiplier
        platformDistance = stage.distanceMultiplier * config.platformDistance
        
        // Removes all platforms, then sets them up again
        platforms.forEach { node in
            node.removeFromParent()
        }
        platforms.removeAll()
        
        setupPlatforms()
        
        
        
        
    }
}
