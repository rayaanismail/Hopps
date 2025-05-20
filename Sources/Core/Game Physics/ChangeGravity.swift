//
//  ChangeGravity.swift
//  HoppsTestScene
//
//  Created by Rayaan Ismail on 5/20/25.
//

import Foundation
import SpriteKit

extension GameScene {
    /// Changes the gamescenes dy (vertical) gravity value to the exact input.
    func changeGravity(_ value: CGFloat) {
        self.physicsWorld.gravity = CGVector(dx: 0, dy: value)
    }
}
