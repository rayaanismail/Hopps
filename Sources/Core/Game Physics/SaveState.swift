//
//  SaveState.swift
//  Hopps
//
//  Created by Rayaan Ismail on 5/29/25.
//

import Foundation
import SpriteKit

extension GameScene {
    /// Saves the current state to the class, you can optionally give it a gameOver state. PAUSE THE GAME BEFORE SAVING.
    func saveState(gameOver: Bool) {
        gameState?.score = Int(fetchAltitude())
        gameState?.isGameOver = gameOver
        gameState?.isPaused = isPaused
    }
}
