//
//  NavigationHub.swift
//  HoppsTestScene
//
//  Created by Rayaan Ismail on 5/21/25.
//

import Foundation
import SwiftUI

/// Handles the switching of views seamlessly without built in animations
@Observable
class NavigationHubViewModel {
    var currentView: UIView = .mainMenu
    
    var topBarIconScale: CGFloat = 0.6
    
    enum UIView {
        case mainMenu, settings, gameOverlay, skins
    }
}

struct NavigationHub: View {
    @State var vm = NavigationHubViewModel()
    
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
    NavigationHub()
}
