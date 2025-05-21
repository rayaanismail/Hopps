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
    @State var scene: SKScene = {
        let scene = GameScene()
        scene.scaleMode = .resizeFill
        return scene
    }()
    var body: some View {
        ZStack {
            SpriteView(scene: scene,  isPaused: false)
                .ignoresSafeArea()
            Button {
                scene.isPaused.toggle()
            } label: {
                Image(.pauseIcon)
            }
       
            
        }
    }
}

#Preview {
    GameOverlay(vm: NavigationHubViewModel())
}
