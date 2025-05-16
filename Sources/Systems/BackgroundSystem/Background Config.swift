//
//  Background Config.swift
//  HoppsTestScene
//
//  Created by Rayaan Ismail on 4/19/25.
//

import Foundation
import SpriteKit

struct BackgroundConfig {
    var size: CGSize {
        view.frame.size
    }
    let view: SKView
    let fadeStart: CGFloat = 101000
    let fadeEnd: CGFloat = 105000
    let particleSize: CGFloat = 3
    let progressionManager = ProgressionManager()
    let cloudLayerLowerBound: CGFloat = 1200
    /// Affects the scroll speed of the static background compared to the Camera Position.
    let scrollSpeeds: [CGFloat] = [
        0.017, // Layer 1
        0.025, // Layer 2
        0.075 // Layer 3
    ]
    
    let layerZPositions: [CGFloat] = [
        -60, // Layer 1
        -55, // Layer 2
        -50 // Layer 3
    ]
    
    let cloudZPositions: [CGFloat] = [
        -65, // Layer 1
        -60, // Layer 2
        -55 // Layer 3
    ]
    
    let cloudTypes: [SKTexture] = [SKTexture(image: .cloud1), SKTexture(image: .cloud2), SKTexture(image: .cloud3)]
    /// Scrolls speeds for horizontal cloud scrolling
    let cloudXSpeeds: [CGFloat] = [
        0.017, // Layer 1
        0.025, // Layer 2
        0.075 // Layer 3
    ]
    /// Scroll speeds for vertical cloud scrolling
    let cloudYSpeeds: [CGFloat] = [
        0.017, // Layer 1
        0.020, // Layer 2
        0.023, // Layer 3
        0.09 // Cloud Background
    ]
    /// Initialized with a slightly randomized position. Edit in the config.
    var cloudPositions: [CGPoint]
    
    /// An array with specific sizing for each cloud
    let cloudScale: [CGFloat] = [
        1, // Layer 1
        0.55, // Layer 2
        0.5 // Layer 3
    ]
    
    let cloudXSpeedFactor: CGFloat = 2
    
    /// Proportionally scales all clouds
    let cloudSize: CGFloat = 2
    
    
    init(view: SKView) {
        self.view = view
        let layer1 = localizedCoordinates(origin: CGPoint.zero, view: view, desiredPosition: CGPoint(x: CGFloat.random(in: 0.2...0.3), y: CGFloat.random(in: 0.9...1)))
        let layer2 = localizedCoordinates(origin: CGPoint.zero, view: view, desiredPosition: CGPoint(x: CGFloat.random(in: 0.6...0.75), y: 0.9))
        let layer3 = localizedCoordinates(origin: CGPoint.zero, view: view, desiredPosition: CGPoint(x: CGFloat.random(in: 1.05...1.2), y: CGFloat.random(in: 0.7...0.8)))
        self.cloudPositions = [layer1, layer2, layer3]
    }
}
