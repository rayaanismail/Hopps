//
//  DeathScreenView.swift
//  Hopps
//
//  Created by Analu Jahi on 5/27/25.
//

import SwiftUI

struct DWoodButton: View {
  let title: String
  let action: () -> Void
  @GestureState var pressed = false

  var body: some View {
    Button(action: action) {
      Text(title)
        .font(.custom("Silom", size: 32))
        .foregroundColor(.black)
        .frame(width: 120)
        .padding(.vertical, 12)
        .background(
          Image("woodButton1.5")
            .resizable(
              capInsets: EdgeInsets(top:20, leading:20, bottom:20, trailing:20),
              resizingMode: .stretch
            )
        )
        .scaleEffect(pressed ? 0.95 : 1)
    }
    .simultaneousGesture(
      LongPressGesture(minimumDuration: 0.01)
        .updating($pressed) { curr, state, _ in state = curr }
    )
  }
}

struct DeathScreenView: View {
    let finalAltitude: Int
  var onRetry: () -> Void
  var onHome:  () -> Void

  var body: some View {
    ZStack {
      VStack(spacing: 40) {
          
          Text("Score \(finalAltitude) m")
                   .font(.custom("Silom", size: 28))
                   .foregroundColor(.white)
          
        Image("DeathScreen")
          .resizable()
          .frame(width: 300, height: 300)
          
          WoodButton(title: "Retry", action: onRetry)
          WoodButton(title: "Home",  action: onHome)
        
      }
    }
  }
}


