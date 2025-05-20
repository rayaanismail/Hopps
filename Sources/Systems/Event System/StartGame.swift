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
        if timeData.elapsedTime == 0 {
            cage.alpha = 1
            let character = getScene().fetchCharacter()
            let physicsBodyCopy = getScene().fetchCharacter().physicsBody
            character.physicsBody = nil
            character.position = CGPoint(x: 0, y: -300)
            cage.position = CGPoint(x: 0, y: getScene().fetchCharacter().position.y)
            // Disable Player Movement
            getScene().movement(.pause)
            
            Task {
                try await Task.sleep(for: .seconds(0.5))
                await cage.run(AnimationManager.launchAnimation)
                character.physicsBody = physicsBodyCopy
                getScene().playerSystem?.jump(velocity: 500)
                await cage.run(AnimationManager.launchEffectAnimation)
                
                getScene().movement(.unpause)
            }
        }
    }
}
