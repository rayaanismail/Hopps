//
//  ContentView.swift
//  HoppsTestScene
//
//  Created by Rayaan Ismail on 4/17/25.
//

import SwiftUI
import SpriteKit


struct ContentView: View {
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
    ContentView()
}

