//
//  MovePlayer.swift
//  HoppsTestScene
//
//  Created by Rayaan Ismail on 4/19/25.
//

import Foundation
import SpriteKit

extension PlayerSystem {
    func movePlayer(deltaTime: TimeInterval) {
        guard let targetX = targetX else {
            return
        }
        let currentX = character.position.x
        let dx = targetX - currentX // Gets the difference between the last movement and now
        
//        let direction: CGFloat = deltaPosition.y > 0 ? -1 : 1
        let direction: CGFloat = -1
        // Horizontal movement, interpolating the steps toward target
        let step = dx * moveSpeed * CGFloat(deltaTime) /// Proportional control. (velocity 'movespeed' * target - current) multiplied by the delta time so it is FRAME INDEPENDENT
        /// PID Proportional Integral Derivative. Fine tuned feedback loop that can dampen and accellerate if tuned properly.
        character.position.x += step
        
        // Save smoothed velocity for tilt logic
        previousDx = step
        
        // Rotation angle based on horizontal speed
        let targetRotation = clamp(value: (direction * step) * 0.15, min: -maxTilt, max: maxTilt)
        // Tune 0.25, think of it as 0.25 degrees of tilt per pixel/frame moved.
        
        // Smooth rotation using linear interpolation
        let currentRotation = character.zRotation
        let newRotation = lerp(from: currentRotation, to: targetRotation, amount: tiltSmoothing)
        
        // Rotates the bunny using linear interpolation. The lower the tiltSmoothing value, the snappier the rotation.
        character.zRotation = newRotation
        // Inverts the rotation, so that when moving the rotation is flipped
    }
}
