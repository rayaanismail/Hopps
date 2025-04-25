//
//  ProgressionManager.swift
//  HoppsTestScene
//
//  Created by Rayaan Ismail on 4/25/25.
//

import Foundation
import SpriteKit

struct ProgressionStage {
    var range: Range<CGFloat>
    var distanceMultiplier: CGFloat
    var jumpHeightMultiplier: CGFloat
    
    var platformDistribution: [(style: PlatformStyle, percentage: CGFloat)]
}
struct ProgressionManager {
    // MARK: STAGE ARRAY
    var stages: [ProgressionStage]
    
    /// Initial Stage 0-25k
    /// Normal Distribution and Modifiers
    let stageOne = ProgressionStage(range: -300..<25000, distanceMultiplier: 1, jumpHeightMultiplier: 1, platformDistribution: [(style: .stationary, percentage: 1)])
    
    /// Second Stage 25k-50k (30% Moving Platforms)
    /// Normal Distribution and Modifiers
    let stageTwo = ProgressionStage(range: 25000..<50000, distanceMultiplier: 1, jumpHeightMultiplier: 1, platformDistribution: [(style: .stationary, percentage: 0.7), (style: .moving, percentage: 0.3)])
    
    /// Third Stage 50k-75k (50% Moving Platforms)
    /// 25% Distribution Increase, 20% Jump Height Increase
    let stageThree = ProgressionStage(range: 50000..<75000, distanceMultiplier: 1.25, jumpHeightMultiplier: 1.2, platformDistribution: [(style: .stationary, percentage: 0.5), (style: .moving, percentage: 0.5)])
    
    /// Fourth Stage 75k+ (50% Moving Platforms)
    /// 50% Distribution Increase, 40% Jump Height Increase
    let stageFour = ProgressionStage(range: 75000..<CGFloat.greatestFiniteMagnitude, distanceMultiplier: 1.5, jumpHeightMultiplier: 1.4, platformDistribution: [(style: .stationary, percentage: 0.5), (style: .moving, percentage: 0.5)])
    
    init() {
        self.stages = [stageOne, stageTwo, stageThree, stageFour]
    }
    
    
}
