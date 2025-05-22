//
//  GameOverlay.swift
//  HoppsTestScene
//
//  Created by Rayaan Ismail on 5/21/25.
//

import SwiftUI
import SpriteKit

struct GameOverlay: View {
    @Bindable var vm: NavigationHubViewModel

    /// Simple bool to track paused state
    @State var isPaused = false


    @State var scene: SKScene = {
        let scene = GameScene()
        scene.scaleMode = .resizeFill
        return scene
    }()

    var body: some View {
        ZStack {
            // Game view, paused when isPaused is true
            SpriteView(scene: scene)
                .ignoresSafeArea()

            // Pause screen overlay
            if isPaused {
                PauseScreenView {
                    isPaused = false
                }
                .zIndex(1)
            }
          

            // Pause button always on top
            VStack {
                HStack {
                    Spacer()
                    Button {
                        // Check if the scene has been restarted, and update the scene
                        isPaused.toggle()
                        scene.isPaused = isPaused
                    } label: {
                        Image(.pauseIcon)
                            .resizable()
                            .frame(width: 36, height: 36)
                            .padding()
                    }
                }
                Spacer()
            }
            .zIndex(2)
        }
    }
}

#Preview {
    GameOverlay(vm: NavigationHubViewModel())
}
