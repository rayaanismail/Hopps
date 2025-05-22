//
//  PauseScreenView.swift
//  HoppsTestScene
//
//  Created by Analu Jahi on 5/21/25.
//

import SwiftUI

struct PauseScreenView: View {
    // callbacks for each button tap
    var onResume: () -> Void = { }
    var onHome: () -> Void = { }

    var body: some View {
        ZStack {
            // optional dimmed background
            Color.black.opacity(0.4)
                .ignoresSafeArea()

            VStack(spacing: 20) {
                WoodButton(title: "Resume",     action: onResume)
                WoodButton(title: "Home",       action: onHome)
            }
        }
    }
}

struct WoodButton: View {
    let title: String
    let action: () -> Void

    @GestureState private var isPressed = false

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

struct PauseScreenView_Previews: PreviewProvider {
    static var previews: some View {
        PauseScreenView(
            onResume:     { print("Resume") },
            onHome:       { print("Home") }
        )
    }
}

