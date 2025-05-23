//
//  GameOverlay.swift
//  HoppsTestScene
//
//  Created by Rayaan Ismail on 5/21/25.
//

import SwiftUI
import SpriteKit

extension Notification.Name {
  static let gameDidRestart = Notification.Name("GameScene.gameDidRestart")
}

struct GameOverlay: View {
    @Bindable var vm: NavigationHubViewModel
    @State      var isPaused = false
    @State      var scene: GameScene = {
        let scene = GameScene()
        scene.scaleMode = .resizeFill
        return scene
    }()

    var body: some View {
        ZStack {
            SpriteView(scene: scene, isPaused: isPaused)
               
                .ignoresSafeArea()
                .onReceive(NotificationCenter.default.publisher(for: .gameDidRestart)) { notif in
                    if let newScene = notif.object as? GameScene {
                        scene = newScene
                    }
                }

            // Pause sheet
            if isPaused {
                PauseScreenView(
                    onResume: {
                        isPaused = false
                        scene.isPaused = isPaused
                    },
                    onHome: {
                        scene.isPaused = true
                        scene.restart()
                        vm.currentView = .mainMenu
                    }
                )
                
                .zIndex(1)
            }
            

            /// Pause button
            VStack {
                HStack {
                    Spacer()
                    Button {
                        isPaused.toggle()
                        scene.isPaused = isPaused
                    } label: {
                        Image(.pauseIcon)
                            .resizable()
                            .frame(width: 36, height: 36)
                            .padding()
                            .opacity(isPaused ? 0 : 1)
                            .disabled(isPaused)
                            .animation(.linear(duration: 0), value: isPaused)
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
