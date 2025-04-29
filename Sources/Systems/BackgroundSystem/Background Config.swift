//
//  Background Config.swift
//  HoppsTestScene
//
//  Created by Rayaan Ismail on 4/19/25.
//

import Foundation

struct BackgroundConfig {
    let size: CGSize
    let fadeStart: CGFloat
    let fadeEnd: CGFloat
    let particleSize: CGFloat
    /// Affects the scroll speed of the static background compared to the Camera Position.
    let scrollSpeed: CGFloat = 0.05
}
