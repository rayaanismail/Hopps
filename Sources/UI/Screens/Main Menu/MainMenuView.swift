//
//  MainMenuView.swift
//  HoppsTestScene
//
//  Created by Rayaan Ismail on 5/21/25.
//

import SwiftUI

struct MainMenuView: View {
    @Bindable var vm: NavigationHubViewModel
    var body: some View {
        ZStack {
            // Background, bottom layer
            BlurredBackground()
            
            GeometryReader { geo in
                // Leaderboard and Settings Buttons
                HStack {
                    Button {
                        /// Trigger Leaderboard
                    } label: {
                        Image(.leaderboardTrophy)
                            .scaleEffect(vm.menuIconScale)
                    }
                    Spacer()
                    Button {
                        vm.currentView = .settings
                    } label: {
                        Image(.settingsIcon)
                            .scaleEffect(vm.menuIconScale)
                    }
                    
                }
                
                VStack {
                    // MARK: Missing Sitting Bunny Asset
                    Button {
                        vm.currentView = .gameOverlay
                    } label: {
                        WoodButton35(text: "Start")
                    }
                    .padding(.bottom, 30)
                    Button {
                        /// Skins Screen
                    } label: {
                        WoodButton35(text: "Skins\n(Coming soon)", fontSize: 17)
                            .colorMultiply(.gray)
                    }
                    .disabled(true)
                }
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.top, geo.size.height * 0.5)
                
            }
            .frame(maxHeight: .infinity, alignment: .top)
            /// End of Screen Contents
        }
    }
}

#Preview {
    MainMenuView(vm: NavigationHubViewModel())
}
