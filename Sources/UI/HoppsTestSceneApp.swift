//
//  HoppsTestSceneApp.swift
//  HoppsTestScene
//
//  Created by Rayaan Ismail on 4/17/25.
//

import SwiftUI

@main
struct HoppsTestSceneApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationHub(vm: NavigationHubViewModel())
        }
    }
    
    init() {
        // Automatically registers touchenabled and vibration enabled
        UserDefaults.standard.register(defaults: ["touchEnabled": true])
        UserDefaults.standard.register(defaults: ["vibrationEnabled": true])
        UserDefaults.standard.register(defaults: ["sfxEnabled": true])
        
        GameCenterManager.shared.authenticateLocalPlayer()
        

    }
}
