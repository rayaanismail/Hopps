//
//  GetPlatformThreshold.swift
//  HoppsTestScene
//
//  Created by Rayaan Ismail on 4/29/25.
//

import Foundation
import SpriteKit

extension PlayerSystem {
    func getPlatformThreshold() -> CGFloat {
        (scene as? GameScene)?.fetchThresholdY() ?? 0
    }
}
