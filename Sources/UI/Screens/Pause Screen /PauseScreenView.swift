//
//  PauseScreenView.swift
//  HoppsTestScene
//
//  Created by Analu Jahi on 5/21/25.
//

import SwiftUI

struct PauseScreenView: View {
    /// Called when you tap “Resume”
    var onResume: () -> Void

    var body: some View {
        // Semi-transparent black backdrop
        Color.black.opacity(0.6)
            .ignoresSafeArea()
            .overlay(
                VStack(spacing: 20) {
                    Text("Paused")
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(.white)

                    Button(action: onResume) {
                        Label("Resume", systemImage: "play.circle.fill")
                            .font(.title2)
                            .foregroundColor(.white)
                            .padding(.horizontal, 24)
                            .padding(.vertical, 12)
                            .background(.ultraThinMaterial, in: Capsule())
                    }
                }
            )
    }
}
