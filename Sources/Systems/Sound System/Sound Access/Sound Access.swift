//
//  Sound Access.swift
//  Hopps
//
//  Created by Rayaan Ismail on 6/6/25.
//

import Foundation
import SpriteKit

extension SoundSystem {
    func getScene() -> GameScene {
        (scene as? GameScene) ?? GameScene()
    }
    
    func getSettings() -> (sfxEnabled: Bool, vibrationEnabled: Bool, touchEnabled: Bool) {
        return ((sfxEnabled: getScene().sfxEnabled, vibrationEnabled: getScene().vibrationEnabled, touchEnabled: getScene().touchEnabled))
    }
}
