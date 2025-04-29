//
//  Helpers.swift
//  HoppsTestScene
//
//  Created by Rayaan Ismail on 4/29/25.
//

import Foundation
import SpriteKit
import GameplayKit

extension PlatformSystem {
    
    /// Uses the index to create alternating positions, offset by their index and spacing, as well as a dedicated distancing x offset
    func randomPosition(index: Int, setup: Bool = false) -> CGPoint {
        let even = index % 2 == 0
        
        /// Random value from 0 to width of phone screen
        var randomX = CGFloat.random(in: 0...width) - (width / 2)
        let setupOffset = setup == true ? config.platformSpawnOffset : lastPlatformY + 100
        
        /// Offsets positions based on index.
        if even {
            randomX = clamp(value: (randomX + config.platformOffset), min: margin.lower, max: margin.upper)
            return CGPoint(x: randomX, y: (platformDistance * CGFloat(index)) + setupOffset)
        } else {
            randomX = clamp(value: (randomX - config.platformOffset), min: margin.lower, max: margin.upper)
            return CGPoint(x: randomX, y: (platformDistance * CGFloat(index)) + setupOffset)
        }
    }
}
