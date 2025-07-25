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
            character.physicsBody?.isDynamic = false
            character.position = CGPoint(x: 0, y: -300)
            cage.position = CGPoint(x: 0, y: getScene().fetchCharacter().position.y)
            // Disable Player Movement
            getScene().movement(.pause)
            getScene().camera?.position = CGPoint.zero
            
            Task {
                try await Task.sleep(for: .seconds(0.5))
                await cage.run(AnimationManager.launchAnimation)
                getSoundSystem().playCannonSFX()
                character.physicsBody?.isDynamic = true
                getScene().playerSystem?.jump(velocity: 8000)
                getHapticEngine().playCannonHaptic()
                await cage.run(AnimationManager.launchEffectAnimation)
                getSoundSystem().playBackgroundTheme()
                
                getScene().movement(.unpause)
            }
        }
    }
}
