//
//  NavigationHub.swift
//  HoppsTestScene
//
//  Created by Rayaan Ismail on 5/21/25.
//

import GameKit
import Foundation
import SwiftUI

/// Handles the switching of views seamlessly without built in animations
@Observable
class NavigationHubViewModel {
    var currentView: UIView = .mainMenu
    var topBarIconScale: CGFloat = 1.2
    var touchEnabled: Bool
    var vibrationEnabled: Bool
    var sfxEnabled: Bool
    var scene: GameScene? = nil
    
    enum UIView {
        case mainMenu, settings, gameOverlay, skins
    }
    
    init(scene: GameScene = GameScene()) {
        self.touchEnabled = UserDefaults.standard.bool(forKey: "touchEnabled")
        self.vibrationEnabled = UserDefaults.standard.bool(forKey: "vibrationEnabled")
        self.sfxEnabled = UserDefaults.standard.bool(forKey: "sfxEnabled")
    }
}

struct NavigationHub: View {
    @State var vm: NavigationHubViewModel
    
    
    var body: some View {
        ZStack {
            switch vm.currentView {
                
            case .mainMenu:
                MainMenuView(vm: vm)
            case .settings:
                SettingsView(vm: vm)
            case .gameOverlay:
                GameOverlay(vm: vm)
                
                
                
            default:
                MainMenuView(vm: vm)
            }
        }
        .animation(.easeIn, value: vm.currentView)
        
    }
}


#Preview {
    var scene: GameScene = {
        let scene = GameScene()
        scene.scaleMode = .resizeFill
        return scene
    }()
    
    NavigationHub(vm: NavigationHubViewModel(scene: scene))
}
