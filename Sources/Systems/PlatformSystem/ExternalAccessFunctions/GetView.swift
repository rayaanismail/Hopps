//
//  GetAltitude.swift
//  HoppsTestScene
//
//  Created by Rayaan Ismail on 4/29/25.
//

import Foundation
import SpriteKit

extension PlatformSystem {
    func getView() -> SKView {
        (scene as? GameScene)?.fetchView() ?? SKView(frame: CGRect.zero)
    }
}
