//
//  PlatformStyle.swift
//  HoppsTestScene
//
//  Created by Rayaan Ismail on 4/25/25.
//
import Foundation

enum PlatformStyle {
    case stationary, moving, destructible
}

struct PlatformConfig {
    var platformBatch = 10
    var platformDistance: CGFloat = 250
    var platformWidth: CGFloat = 250
    var platformBounceVelocity: CGFloat = 150
}
