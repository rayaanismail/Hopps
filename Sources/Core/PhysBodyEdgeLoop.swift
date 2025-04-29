//
//  PhysBodyEdgeLoop.swift
//  HoppsTestScene
//
//  Created by Rayaan Ismail on 4/28/25.
//

import Foundation
import SpriteKit

extension GameScene {
    /// Offset the scenes physics body by half of the view (anchor point is 0, so this doesnt affect anything except for the collision at 0,0)
    func physicsBodyEdgeLoop() -> CGRect {
        camera!.frame.offsetBy(dx: 0, dy: -self.view!.frame.height)
    }
}
