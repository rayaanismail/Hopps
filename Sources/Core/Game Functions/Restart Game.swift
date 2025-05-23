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
        let newScene = GameScene(size: view!.frame.size)
        newScene.scaleMode = .resizeFill
        view!.presentScene(newScene, transition: .fade(withDuration: 1))
        let finalAltitude = Int(fetchAltitude())
        GameCenterManager.shared.submitScore(finalAltitude)
        
        // tell SwiftUI about the brand-new scene
        NotificationCenter.default.post(
            name: .gameDidRestart,
            object: newScene
        )
    }
}

