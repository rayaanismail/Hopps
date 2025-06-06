//
//  HapticAccess.swift
//  Hopps
//
//  Created by Rayaan Ismail on 6/2/25.
//

import Foundation

extension HapticSystem {
    func getScene() -> GameScene {
        scene as? GameScene ?? GameScene()
    }
}
