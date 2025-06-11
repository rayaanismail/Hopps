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
        eventSystem?.startGame()
        platformSystem?.resetPlatformData()
        backgroundSystem?.resetBackground()
        GameCenterManager.shared.submitScore(Int(fetchAltitude()))
        
        touchEnabled = UserDefaults.standard.bool(forKey: "touchEnabled")
        vibrationEnabled = UserDefaults.standard.bool(forKey: "vibrationEnabled")
        sfxEnabled = UserDefaults.standard.bool(forKey: "sfxEnabled")
    }
}
