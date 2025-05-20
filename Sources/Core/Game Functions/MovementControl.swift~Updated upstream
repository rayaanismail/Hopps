//
//  PauseMovementControl.swift
//  HoppsTestScene
//
//  Created by Rayaan Ismail on 5/7/25.
//

import Foundation
import SpriteKit

extension GameScene {
    enum MovementControl {
        case pause, unpause
    }
    
    /// Can enable/disable the players ability to control movement
    func movement(_ type: MovementControl) {
        switch type {
        case .pause:
            playerSystem?.canMove = false
        case .unpause:
            playerSystem?.canMove = true
        }
    }
}
