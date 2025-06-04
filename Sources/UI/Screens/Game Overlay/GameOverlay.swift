//
//  GameOverlay.swift
//  HoppsTestScene
//
//  Created by Rayaan Ismail on 5/21/25.
//

import SwiftUI
import SpriteKit

struct GameOverlay: View {
    @State var vm: NavigationHubViewModel
    @StateObject var gameState: GameState = GameState()
    @State var scene: GameScene = {
        let newScene = GameScene()
        newScene.scaleMode = .resizeFill
        return newScene
    }()
    
    var body: some View {
        ZStack {
            SpriteView(scene: scene)
                .ignoresSafeArea()
                .disabled(gameState.isPaused || gameState.isGameOver)
                .onAppear {
                    scene.gameState = gameState
                }
            
            if gameState.isPaused && !gameState.isGameOver{
                PauseScreenView(scene: $scene, gameState: gameState, vm: $vm)
                
            } else if !gameState.isPaused && !gameState.isGameOver {
                Button {
                    setPauseState(!gameState.isPaused)
                } label: {
                    Image(.pauseIcon)
                }
                .scaleEffect(0.6)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                .padding(.horizontal)
                .padding(.top, -25)
            } else if gameState.isGameOver {
                DeathScreenView(vm: $vm, scene: $scene, gameState: gameState)
                    .onAppear {
                        setPauseState(true)
                        GameCenterManager.shared.submitScore(Int(getAltitude()))
                        
                    }
            }
            
        }
    }
    
    func makeScene() -> GameScene {
        let newScene = GameScene()
        newScene.scaleMode = .resizeFill
//        resetGameState()
        newScene.gameState = gameState
        return newScene
    }
    
    func setPauseState(_ input: Bool) {
        gameState.isPaused = input
        scene.isPaused = input
    }
    
    func getAltitude() -> CGFloat {
        scene.fetchAltitude()
    }
    
}

#Preview {
    GameOverlay(vm: NavigationHubViewModel())
}
