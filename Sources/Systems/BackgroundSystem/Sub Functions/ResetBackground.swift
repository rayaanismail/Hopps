//
//  ResetBackground.swift
//  Hopps
//
//  Created by Rayaan Ismail on 6/3/25.
//

import SpriteKit


extension BackgroundSystem {
    func resetBackground() {
        /// Remove current cloud nodes and their actions
        cloudLayers.forEach {
            $0.removeAllActions()
            $0.removeFromParent()
        }
        cloudLayers.removeAll()
        
        /// Create new clouds
        cloudLayers = createClouds(config: config)
        /// Add the new clouds as children and run spritekit actions on them
        cloudLayers.forEach {
            addChild($0)
            $0.run(SKAction.moveBy(x: -config.size.width * 1.3, y: 0, duration: 100))}
    }
}
