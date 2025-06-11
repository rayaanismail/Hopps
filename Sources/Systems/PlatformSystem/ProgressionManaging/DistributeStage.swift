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
        getScene().changeGravity(progressionManager.currentStage.gravity * -9.81)
        if altitude > progressionManager.currentStageUpperBound {
            
            progressionManager.setCurrentStage(altitude)
            let stage = progressionManager.currentStage
            jumpFactor = stage.jumpHeightMultiplier
            
            platformDistance = stage.distanceMultiplier * config.platformDistance
            
            if progressionManager.currentStage.range == progressionManager.stageThree.range {
                print("YOOO")
                getScene().enemySystem?.updateEnemyType(.floating)
                getScene().cameraSystem?.altitudeLabel.fontColor = .white
                getScene().playerSystem?.prepareForSpace()
            }
        } else {
            return
        }
        
        
    }
}
