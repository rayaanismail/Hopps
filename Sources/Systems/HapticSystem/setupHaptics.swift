//
//  setupHaptics.swift
//  Hopps
//
//  Created by Rayaan Ismail on 6/3/25.
//

import Foundation
import CoreHaptics

extension HapticSystem {
    /// Creates and starts the haptic engine (if supported)
    func setupHaptics() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        do {
            engine = try CHHapticEngine()
            try engine?.start()
        } catch {
            print("Haptic engine Creation Error: \(error)")
        }
    }
}
