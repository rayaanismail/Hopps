//
//  FetchAltitude.swift
//  HoppsTestScene
//
//  Created by Rayaan Ismail on 4/28/25.
//

import Foundation
import SpriteKit

extension GameScene {
    func fetchCharacter() -> SKNode {
        return playerSystem?.character ?? SKSpriteNode(color: .purple, size: CGSize(width: 50, height: 75))
    }
    func fetchAltitude() -> CGFloat {
        return playerSystem?.altitude ?? 0
    }
}
