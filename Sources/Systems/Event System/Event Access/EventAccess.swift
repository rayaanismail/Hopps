//
//  External Access.swift
//  HoppsTestScene
//
//  Created by Rayaan Ismail on 4/29/25.
//

import Foundation
import SpriteKit

extension EventSystem {
    /// Fetches the event system GameScene, call fetch functions to access data.
    func getScene() -> GameScene {
        return (scene as? GameScene) ?? GameScene(size: CGSize.zero)
    }
}
