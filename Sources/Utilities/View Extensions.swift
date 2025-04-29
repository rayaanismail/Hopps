//
//  View Extensions.swift
//  HoppsTestScene
//
//  Created by Rayaan Ismail on 4/28/25.
//

import Foundation
import SpriteKit

extension SKView {
    /// Returns the half of the height of the view, useful when calculating distance from a view origin with a center anchorpoint.
    func halfHeight() -> CGFloat {
        return self.frame.height / 2
    }
    /// Returns the half of the width of the view, useful when calculating distance from a view origin with a center anchorpoint.
    func halfWidth() -> CGFloat {
        return self.frame.width / 2
    }
}
