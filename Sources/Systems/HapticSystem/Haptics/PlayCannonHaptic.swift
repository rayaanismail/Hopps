//
//  PlayCannonHaptic.swift
//  Hopps
//
//  Created by Rayaan Ismail on 6/3/25.
//

import Foundation
import CoreHaptics

extension HapticSystem {
    func playCannonHaptic() {
        guard getScene().vibrationEnabled else { return }
        guard let engine = engine else { return }
        let echoDuration: TimeInterval = 1.5
        let echoRelativeTime: TimeInterval = 0.05
        /// Soft punch: still full intensity, lower sharpness
        let punch = CHHapticEvent(
            eventType: .hapticTransient,
            parameters: [
                .init(parameterID: .hapticIntensity, value: 1.0),
                .init(parameterID: .hapticSharpness, value: 0.5) // Softer edge
            ],
            relativeTime: 0
        )
        
        /// Feathered follow-through right after punch
        let body = CHHapticEvent(
            eventType: .hapticContinuous,
            parameters: [
                .init(parameterID: .hapticIntensity, value: 0.7),
                .init(parameterID: .hapticSharpness, value: 0.3)
            ],
            relativeTime: 0.01,
            duration: 0.1
        )
        /// Delayed haptic echo to simulate cannon sending a soundwave throughout the landscape
        let echo = CHHapticEvent(
            eventType: .hapticContinuous,
            parameters: [
                .init(parameterID: .hapticIntensity, value: 0.6),
                .init(parameterID: .hapticSharpness, value: 0.4)
            ],
            relativeTime: echoRelativeTime,
            duration: echoDuration
        )
        
        /// Intensity curve for echo falloff
        let decayCurve = CHHapticParameterCurve(
            parameterID: .hapticIntensityControl,
            controlPoints: [
                .init(relativeTime: 0.0, value: 0.6),
                .init(relativeTime: 0.5, value: 0.4),
                .init(relativeTime: 1.0, value: 0.2),
                .init(relativeTime: echoDuration, value: 0.0)
            ],
            relativeTime: echoRelativeTime
        )
        
        /// Sharpnes curve
        let sharpnessCurve = CHHapticParameterCurve(
            parameterID: .hapticSharpnessControl,
            controlPoints: [
                .init(relativeTime: 0.0, value: 0.8),
                .init(relativeTime: echoDuration, value: 0.0)
            ],
            relativeTime: echoRelativeTime
        )
        do {
            let pattern = try CHHapticPattern(events: [punch, body, echo], parameterCurves: [decayCurve, sharpnessCurve])
            let player = try engine.makePlayer(with: pattern)
            try player.start(atTime: 0)
        } catch {
            print("Cannon haptic playback error: \(error)")
        }
    }
}
