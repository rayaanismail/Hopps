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
    static let playerDied     = Notification.Name("GameScene.playerDied")
}

struct GameOverlay: View {
    @Environment(\.scenePhase) var scenePhase
    @Bindable var vm: NavigationHubViewModel
    @State var finalAltitude: Int = 0
    @State      var isPaused = false
    @State var didDie = false
    @State      var scene: GameScene = {
        let scene = GameScene()
        scene.scaleMode = .resizeFill
        return scene
    }()
    
    var body: some View {
        ZStack {
            SpriteView(scene: scene, isPaused: isPaused || didDie)
                .ignoresSafeArea()
            //  When our restart() posts this, swap in the new scene:
                .onReceive(NotificationCenter.default.publisher(for: .gameDidRestart)) { note in
                   // print(" GameDidRestart received in overlay:", note.object as Any)
                    if let newScene = note.object as? GameScene {
                        scene    = newScene
                        isPaused = false
                        didDie   = false
                    }
                }
            //  When the player dies, flip the flag:
                .onReceive(NotificationCenter.default.publisher(for: .playerDied)) { _ in
                    finalAltitude = Int(scene.fetchAltitude())
                    didDie = true
                }
            //  And if ever navigate back into the game overlay, reset everything:
                .onChange(of: vm.currentView) { oldView, newView in
                    if newView == .gameOverlay {
                        let fresh = GameScene(size: UIScreen.main.bounds.size)
                        fresh.scaleMode = .resizeFill
                        scene    = fresh
                        isPaused = false
                        didDie   = false
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
            
            if didDie {
                //
                Color.black
                    .ignoresSafeArea()
                    .zIndex(2)
            
                //
                DeathScreenView(
                    finalAltitude: finalAltitude, onRetry: {
                        didDie = false
                        scene.restart()
                        scene.isPaused = false
                        
                    },
                    onHome: {
                        didDie = false
                        scene.restart()
                        vm.currentView = .mainMenu
                    }
                )
                .zIndex(3)
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
                            .opacity(didDie ? 0 : 1)
                            .disabled(isPaused)
                            .animation(.linear(duration: 0), value: isPaused)
                            .animation(.linear(duration: 0), value: didDie)
                    }
                }
                Spacer()
            }
            .zIndex(2)
        }
    }
    
    
  
}
