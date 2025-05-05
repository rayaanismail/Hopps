//
//  Background Config.swift
//  HoppsTestScene
//
//  Created by Rayaan Ismail on 4/19/25.
//

import Foundation

struct BackgroundConfig {
    let size: CGSize
    let fadeStart: CGFloat = 50000
    let fadeEnd: CGFloat = 100000
    let particleSize: CGFloat = 3
    /// Affects the scroll speed of the static background compared to the Camera Position.
    let scrollSpeeds: [CGFloat] = [
        0.017, // Layer 1
        0.025, // Layer 2
        0.075 // Layer 3
    ]
}
