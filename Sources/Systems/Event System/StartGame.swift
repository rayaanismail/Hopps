//
//  StartGame.swift
//  HoppsTestScene
//
//  Created by Rayaan Ismail on 5/7/25.
//

import Foundation
import SpriteKit

extension EventSystem {
    /// Spawns a cage at the players location, triggers the animation, and triggers a upward impulse
    func startGame() {
        cage.alpha = 1
        cage.position = getScene().fetchCharacter().position
        // Disable Player Movement
        getScene().movement(.pause)
        
        
        Task {
            
            try await Task.sleep(for: .seconds(0.5))
            await cage.run(AnimationManager.cageJump)
            await getScene().fetchCharacter().run(AnimationManager.jumpAnimation)
            getScene().playerSystem?.jump(velocity: 500)
            
            getScene().movement(.unpause)
        }
        
        
        
        
    }
}
