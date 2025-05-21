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
    var scene: SKScene {
        let scene = GameScene()
        scene.scaleMode = .resizeFill
        return scene
    }
    var body: some View {
        VStack {
            SpriteView(scene: scene,  isPaused: false)
                .ignoresSafeArea()
        }
    }
}

#Preview {
    GameOverlay(vm: NavigationHubViewModel())
}
