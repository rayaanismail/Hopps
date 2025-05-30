//
//  Camera Access Functions.swift
//  Hopps
//
//  Created by Rayaan Ismail on 5/29/25.
//

import Foundation
import SpriteKit

extension CameraSystem {
    func getScene() -> GameScene {
        (scene as? GameScene) ?? GameScene()
    }
}
