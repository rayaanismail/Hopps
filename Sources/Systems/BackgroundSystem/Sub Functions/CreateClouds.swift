//
//  CreateCloud.swift
//  HoppsTestScene
//
//  Created by Rayaan Ismail on 5/12/25.
//

import Foundation
import SpriteKit

extension BackgroundSystem {
    /// Creates cloud array and configures each cloud to its settings within the config
    func createClouds(config: BackgroundConfig) -> [SKSpriteNode] {
        var cloudArray = [SKSpriteNode]()
        
        /// Configures each cloud according to their layer
        for i in 0...2 {
            let cloud = SKSpriteNode(texture: config.cloudTypes[i])
            cloud.alpha = 0.95
            cloud.zPosition = config.cloudZPositions[i]
            cloud.position = config.cloudPositions[i]
            cloud.setScale(config.cloudSize * config.cloudScale[i])
            cloudArray.append(cloud)
        }
        
        return cloudArray
    }
}
