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
/// Returns a cgpoint based around an origin point and a view size.
/// - Parameters:
///   - origin: The point of which the coordinate is based on.
///   - frame: The size of the phone, in CGRect format.
///   - desiredPosition: A coordinate plane with (0,0) being the bottom right and (1,1) being the top left.
/// - Returns: Returns a coordinate at any position on/off the screen based on an origin point.
func localizedCoordinates(origin: CGPoint, view: SKView, desiredPosition: CGPoint) -> CGPoint {
    let frame = view.frame
    
    /// The formula is base + (desiredN * screendistance) - halfscreen distance
    let desiredX = origin.x + (desiredPosition.x * frame.width) - view.halfWidth()
    let desiredY = origin.y + (desiredPosition.y * frame.height) - view.halfHeight()
    print(CGPoint(x: desiredX, y: desiredY))
    return CGPoint(x: desiredX, y: desiredY)
}
