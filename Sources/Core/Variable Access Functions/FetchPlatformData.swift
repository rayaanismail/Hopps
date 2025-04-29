//
//  FetchPlatformData.swift
//  HoppsTestScene
//
//  Created by Rayaan Ismail on 4/29/25.
//

import Foundation
import SpriteKit

extension GameScene {
    func fetchThresholdY() -> CGFloat{
        platformSystem?.spawnThresholdY ?? 0
    }
}
