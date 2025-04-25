//
//  Game System Protocol.swift
//  HoppsTestScene
//
//  Created by Rayaan Ismail on 4/19/25.
//

import Foundation
import SpriteKit

protocol GameSystem {
    func update(deltaTime: TimeInterval)
    func setup(in scene: SKScene)
}
