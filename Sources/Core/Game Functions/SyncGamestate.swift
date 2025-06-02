//
//  SyncGamestate.swift
//  Hopps
//
//  Created by Rayaan Ismail on 5/30/25.
//

import Foundation
import SpriteKit

extension GameScene {
    /// Unwraps gamestate and compares to the isPaused variable, if they are out of sync it sets isPaused to the gamestate.
    func SyncGamestate() {
        if let state = gameState?.isPaused {
            if state != isPaused {
                isPaused = state
                print("Synced the pause")
            }
        }
    }
}
