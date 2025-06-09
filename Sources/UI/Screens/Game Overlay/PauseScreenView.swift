//
//  PauseScreenView.swift
//  HoppsTestScene
//
//  Created by Analu Jahi on 5/21/25.
//

import SwiftUI

struct PauseScreenView: View {
    // callbacks for each button tap
    var scene: Binding<GameScene>
    @StateObject var gameState: GameState
    var vm: Binding<NavigationHubViewModel>

    var body: some View {
        ZStack {
            // optional dimmed background
            Color.black.opacity(0.4)
                .ignoresSafeArea()

            VStack(spacing: 20) {
                WoodButton(title: "Resume") {
                    gameState.isPaused = false
                    scene.isPaused.wrappedValue = false
                    scene.wrappedValue.soundSystem?.pausePersistentAudio(false)
                    
                }
                WoodButton(title: "Home") {
                    vm.wrappedValue.currentView = .mainMenu
                    gameState.isPaused = true
                    scene.wrappedValue.prepareDeinit()
                }
            }
        }
    }
}

struct WoodButton: View {
    let title: String
    let action: () -> Void

    @GestureState var isPressed = false

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.custom("Silom", size: 36))
                .foregroundColor(.black)
                .frame(maxWidth: 300)
                .padding(.vertical, 16)
                .background(
                    Image("woodButton1.5")
                        .resizable(
                            capInsets: EdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20),
                            resizingMode: .stretch
                        )
                )
                .scaleEffect(isPressed ? 0.95 : 1.0)
        }
        // track the press state to drive the scale effect
        .simultaneousGesture(
            LongPressGesture(minimumDuration: 0.01)
                .updating($isPressed) { currentState, gestureState, _ in
                    gestureState = currentState
                }
        )
    }
}

