//
//  SaveSettings.swift
//  HoppsTestScene
//
//  Created by Rayaan Ismail on 5/22/25.
//

import Foundation
import SwiftUI

extension NavigationHubViewModel {
    /// Saves current setting configuration
    func saveSettings() {
        // Commits current configuration to memory
        UserDefaults.standard.set(touchEnabled, forKey: "touchEnabled")
        UserDefaults.standard.set(vibrationEnabled, forKey: "vibrationEnabled")
        UserDefaults.standard.set(sfxEnabled, forKey: "sfxEnabled")
    }
}
