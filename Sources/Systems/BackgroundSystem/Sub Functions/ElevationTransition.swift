//
//  ElevationTransition.swift
//  HoppsTestScene
//
//  Created by Rayaan Ismail on 4/28/25.
//

import Foundation
import SpriteKit

extension BackgroundSystem {
    func elevationTransition() {
        let altitude = getAltitude()
        let maxOpacity: CGFloat = 1
        // Fade to space based on altitude
        
        // Normalize altitude into a range [0, 1] for blending
        var t: CGFloat
        if altitude <= fadeStart {
            t = 0.0
        } else if altitude >= fadeEnd {
            t = maxOpacity
        } else {
            t = (altitude - fadeStart) / (fadeEnd - fadeStart)
            t = clamp(value: t, min: 0, max: maxOpacity)
        }
        
        // --- Layer Adjustments ---
        // Fade in the black "space" overlay gradually
        spaceOverlay.alpha = t
        
        // Fade out the soft white gradient as we rise into space
        let maxGradientAlpha: CGFloat = 0.9
        gradientFade.alpha = (1.0 - t) * maxGradientAlpha
        
        spaceOverlay.alpha = t
        stars.alpha = t
        
        // Optional: reduce gradient as space takes over
        gradientFade.alpha = (1 - t) * 0.5 // Lower this to make sky bluer sooner
        
        altitudeLabel.text = "\(altitude)"
        
    }
}
