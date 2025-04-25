//
//  Utility Functions.swift
//  HoppsTestScene
//
//  Created by Rayaan Ismail on 4/19/25.
//

import Foundation
import SpriteKit

// Smoothly interpolate between angles
func lerp(from: CGFloat, to: CGFloat, amount: CGFloat) -> CGFloat {
    return from + (to - from) * amount
}

func clamp(value: CGFloat, min: CGFloat, max: CGFloat) -> CGFloat {
    return Swift.max(min, Swift.min(max, value))
}
