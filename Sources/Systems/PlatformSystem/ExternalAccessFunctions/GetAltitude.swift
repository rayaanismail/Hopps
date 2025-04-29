//
//  GetAltitude.swift
//  HoppsTestScene
//
//  Created by Rayaan Ismail on 4/29/25.
//

import Foundation
import SpriteKit

extension PlatformSystem {
    func getAltitude() -> CGFloat {
        (scene as? GameScene)?.fetchAltitude() ?? 0
    }
}
