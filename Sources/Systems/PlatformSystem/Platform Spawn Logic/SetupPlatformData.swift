//
//  SetupPlatformData.swift
//  HoppsTestScene
//
//  Created by Rayaan Ismail on 4/29/25.
//

import Foundation
import SpriteKit

extension PlatformSystem {
    /// Initializes the data that the platform generation system uses
    func setupPlatformData() {
        let halfWidth = getView().halfWidth()
        
        lastPlatformY = 0
        width = getView().frame.width
        margin = (
            lower: -halfWidth * config.marginPercentage,
            upper: halfWidth * config.marginPercentage
        )
    }
}
