//
//  GetScene.swift
//  HoppsTestScene
//
//  Created by Analu Jahi on 5/5/25.
//

import Foundation
import SpriteKit

extension EnemySystem {
    
    func getScene() -> GameScene {
        return (scene as? GameScene) ?? GameScene(size: CGSize.zero)
    }
    
    func getPlayer() -> SKSpriteNode {
        getScene().playerSystem?.character ?? SKSpriteNode(color: .purple, size: CGSize(width: 10, height: 10))
    }
}
