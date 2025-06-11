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
            Image(.hoppsTitle)
                .resizable()
                .scaledToFit()
                .frame(width: 300, height: 300)
                .padding(.bottom, 400)
            GeometryReader { geo in
                // Leaderboard and Settings Buttons
                HStack {
                    Button {
                        // Ensure the player is authenticated, then show the GC UI
                        // Add a print statement so that we can see if the view is presented
                        GameCenterManager.shared.authenticateLocalPlayer()
                        GameCenterManager.shared.showLeaderboard()
                        
                    } label: {
                        Image(.leaderboardTrophy)
                            .scaleEffect(vm.topBarIconScale)
                    }

                    Spacer()

                    Button {
                        vm.currentView = .settings
                    } label: {
                        Image(.settingsIcon)
                            .scaleEffect(vm.topBarIconScale)
                    }
                }
                .padding(.horizontal, 30)
                .padding(.top, 35)
                
                

                // Main menu buttons
                VStack {
                    WoodButton(title: "Start", action: {
                        vm.currentView = .gameOverlay
                    })
                    .padding(.bottom, 30)

                    WoodButton(title: "Skins\n(Coming Soon)", action: {
                        // Coming soon!
                    })
                    .colorMultiply(.gray)
                    .disabled(true)
                }
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.top, geo.size.height * 0.5)
            }
            .padding(.top, 20)
            .frame(maxHeight: .infinity, alignment: .top)
        }
    }
}

#Preview {
    MainMenuView(vm: NavigationHubViewModel())
}
