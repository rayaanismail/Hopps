//
//  Restart Game.swift
//  HoppsTestScene
//
//  Created by Rayaan Ismail on 4/24/25.
//

import Foundation
import SpriteKit



extension GameScene {
    func restart() {
        let currentTime = gameTime.sceneStartTime + gameTime.elapsedTime
        gameTime.reset(currentTime: currentTime)
//        Goal: (One function)
//        Reset the game back to its starting state.
//
//
//        How:
//        1. Take player back to initial position, behind cannon.
//        2. Move camera back to initial position, CGPoint.zero?
        eventSystem?.startGame()
//        3. Reset platforms back to their threshold
        platformSystem?.resetPlatformData()
//        4. Reset enemies, reinit?
//        5. Restart cannon animation, and apply impulse.
//        6. On death, allow UI to handle transitioning.
//            1. On ‘retry’ reset the game,
        touchEnabled = UserDefaults.standard.bool(forKey: "touchEnabled")
        vibrationEnabled = UserDefaults.standard.bool(forKey: "vibrationEnabled")
        sfxEnabled = UserDefaults.standard.bool(forKey: "sfxEnabled")
        print("touch \(touchEnabled)\nhaptic\(vibrationEnabled)\nsfx \(sfxEnabled)")
        
    }
}


