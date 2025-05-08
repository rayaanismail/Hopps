//
//  Restart Game.swift
//  HoppsTestScene
//
//  Created by Rayaan Ismail on 4/24/25.
//

import Foundation
import SpriteKit

extension GameScene {
    func restart(){
        let gameScene: GameScene = GameScene(size: self.view!.frame.size)
        let transition = SKTransition.fade(withDuration: 2)
        gameScene.scaleMode = SKSceneScaleMode.fill
        self.view!.presentScene(gameScene, transition: transition)
    }
}
