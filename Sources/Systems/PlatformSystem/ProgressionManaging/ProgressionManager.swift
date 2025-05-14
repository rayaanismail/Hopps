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
    
    /// Set style and distribution for different platform types
    var platformDistribution: [(style: PlatformStyle, weight: Int)]
    var textures: [String] = ["WPlatform1"]
    var randomTexture: String {
        return textures.randomElement() ?? "WPlatform1"
    }
    /// Uses the current stages distribution data to efficiently and accurately retrieve a platform type.
    func weightedRandomStyle() -> PlatformStyle {
        let totalWeight = platformDistribution.reduce(0) { $0 + $1.weight } /// Calculates total weight (should be close to 100 if using percentages)
        guard totalWeight > 0 else { return .stationary } /// Protects against division by zero
        
        let randomValue = Int.random(in: 0..<totalWeight) /// Generates random number between 0 ... sum
        
        var cumulativeWeight = 0
        
        for data in platformDistribution {
            cumulativeWeight += data.weight
            if randomValue < cumulativeWeight {
                return data.style
            }
        }
        return .stationary
    }
    
    /// Returns true if altitude is within range
    func isWithinRange(_ altitude: CGFloat) -> Bool {
        return range.contains(altitude)
    }
}


struct ProgressionManager {
    // MARK: STAGE ARRAY
    var stages: [ProgressionStage]
    var currentStage: ProgressionStage
    var currentStageUpperBound: CGFloat = -1
    
    /// Initial Stage 0-25k (5% Moving Platforms)
    /// Normal Distribution and Modifiers
    let stageOne = ProgressionStage(range: -300..<25000, distanceMultiplier: 1, jumpHeightMultiplier: 2, platformDistribution: [(style: .stationary, weight: 80), (style: .moving, weight: 20)])
    
    /// Second Stage 25k-50k (30% Moving Platforms)
    /// Normal Distribution and Modifiers
    let stageTwo = ProgressionStage(range: 25000..<50000, distanceMultiplier: 1, jumpHeightMultiplier: 2, platformDistribution: [(style: .stationary, weight: 70), (style: .moving, weight: 30)])
    
    /// Third Stage 50k-75k (50% Moving Platforms)
    /// 25% Distribution Increase, 20% Jump Height Increase
    let stageThree = ProgressionStage(range: 50000..<75000, distanceMultiplier: 2, jumpHeightMultiplier: 2.4, platformDistribution: [(style: .stationary, weight: 50), (style: .moving, weight: 50)])
    
    /// Fourth Stage 75k+ (50% Moving Platforms)
    /// 50% Distribution Increase, 40% Jump Height Increase
    let stageFour = ProgressionStage(range: 75000..<CGFloat.greatestFiniteMagnitude, distanceMultiplier: 2.8, jumpHeightMultiplier: 3.5, platformDistribution: [(style: .stationary, weight: 50), (style: .moving, weight: 50)])
    
    init() {
        self.stages = [stageOne, stageTwo, stageThree, stageFour]
        self.currentStage = stages[0]
    }
    /// Returns the proper progression stage based on altitude given to it, as well as setting the next stages upper bound.
    /// Upgrade to binary search if there are a lot of stages
    func retrieveStageData(_ altitude: CGFloat) -> ProgressionStage {
        for stage in stages {
            if stage.range.contains(altitude) {
                return stage
            }
        }
        return stages[0]
    }
    
    /// Sets 'currentStageUpperBound' to the next stages lowest value
    mutating func setCurrentStage(_ altitude: CGFloat) {
        for stage in stages {
            if stage.range.contains(altitude) {
                currentStageUpperBound = stage.range.upperBound
                currentStage = stage
            }
        }
    }
}
