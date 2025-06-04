//
//  HapticSystem.swift
//  Hopps
//
//  Created by Rayaan Ismail on 6/2/25.
//

import Foundation
import SpriteKit
import UIKit
import CoreHaptics

class HapticSystem: SKNode, GameSystem {
    /// Connects app to the haptic engine server.
    var engine: CHHapticEngine?
    let platformImpact = UIImpactFeedbackGenerator()
    
    func update(deltaTime: TimeInterval) {
        
    }
    
    func setup(in scene: SKScene) {
        setupHaptics()
    }
    
    /// Triggers the default platform haptic at a specific point, with a default intensity of 0.1, then prepares the haptic engine for the next impact (to reduce latency).
    func triggerPlatformImpact(intensity: CGFloat = 1, at point: CGPoint,) {
        guard getScene().vibrationEnabled else { return }
        platformImpact.impactOccurred(intensity: intensity, at: point)
        platformImpact.prepare()
    }
    
    
}


