//
//  SKSpriteNode Extensions.swift
//  HoppsTestScene
//
//  Created by Rayaan Ismail on 5/19/25.
//

import Foundation
import SpriteKit

extension SKSpriteNode {
    /// Scales current x and y scale by a current factor
    func scaleBy(_ scale: CGFloat) {
        let newScale = self.xScale * scale
        self.setScale(newScale)
    }
}
