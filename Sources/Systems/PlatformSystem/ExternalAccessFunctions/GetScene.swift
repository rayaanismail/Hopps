//
//  GetAltitude.swift
//  HoppsTestScene
//
//  Created by Rayaan Ismail on 4/29/25.
//

import Foundation
import SpriteKit

extension PlatformSystem {
    func getScene() -> GameScene {
        return (scene as? GameScene) ?? GameScene(size: CGSize.zero)
    }
}
