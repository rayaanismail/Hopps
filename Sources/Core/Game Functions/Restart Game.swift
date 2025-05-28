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
    // 1) Build a fresh scene
      print("New scene")
    let newScene = GameScene(size: size)
    newScene.scaleMode = scaleMode
    newScene.isPaused = false          // make extra sure the scene itself isn't paused

//    // 2) Submit your score
//    let finalAltitude = Int(fetchAltitude())
//    GameCenterManager.shared.submitScore(finalAltitude)

    // 3) Swap on the SKView and UNPAUSE it
    if let skView = skViewRef {
      skView.presentScene(
        newScene,
        transition: .fade(withDuration: 1)
      )
      skView.isPaused = false         /// UNPAUSE the view so it actually runs
    }

    // 4) Tell SwiftUI to swap its @State `scene` binding
    
    NotificationCenter.default.post(
      name: .gameDidRestart,
      object: newScene
    )
  }
}


