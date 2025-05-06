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
    var platformBatch = 20
    var platformDistance: CGFloat = 150
    var platformScale: CGFloat = 0.4
    var jumpFactor: CGFloat = 2
    var marginPercentage: CGFloat = 0.7
    var platformOffset: CGFloat = 50
    var platformSpawnOffset: CGFloat = 900
    
    // Integrate into progression
    var platformMoveSpeed: Double = 2
}
