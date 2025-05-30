//
//  DeathScreenView.swift
//  Hopps
//
//  Created by Analu Jahi on 5/27/25.
//

import SwiftUI
import SpriteKit

//struct DWoodButton: View {
//  let title: String
//  let action: () -> Void
//  @GestureState var pressed = false
//
//  var body: some View {
//    Button(action: action) {
//      Text(title)
//        .font(.custom("Silom", size: 32))
//        .foregroundColor(.black)
//        .frame(width: 120)
//        .padding(.vertical, 12)
//        .background(
//          Image("woodButton1.5")
//            .resizable(
//              capInsets: EdgeInsets(top:20, leading:20, bottom:20, trailing:20),
//              resizingMode: .stretch
//            )
//        )
//        .scaleEffect(pressed ? 0.95 : 1)
//    }
//    .simultaneousGesture(
//      LongPressGesture(minimumDuration: 0.01)
//        .updating($pressed) { curr, state, _ in state = curr }
//    )
//  }
//}

struct DeathScreenView: View {
    @State var vm: Binding<NavigationHubViewModel>
    @State var scene: Binding<GameScene>
    @StateObject var gameState: GameState

  var body: some View {
    ZStack {
        Color.black
            .ignoresSafeArea()
            .opacity(0.9)
      VStack(spacing: 40) {
          Text("Score \(gameState.score) m")
                   .font(.custom("Silom", size: 28))
                   .foregroundColor(.white)
          
        Image("DeathScreen")
          .resizable()
          .frame(width: 300, height: 300)
          
          WoodButton(title: "Retry") {
              restart()
          }
          WoodButton(title: "Home") {
              restart()
              gameState.isPaused = true
              scene.wrappedValue.isPaused = true
              vm.wrappedValue.currentView = .mainMenu
          }
        
      }
    }
  }
    
    func restart() {
        scene.wrappedValue.restart()
        scene.wrappedValue.isPaused = false
        gameState.isPaused = false
        gameState.isGameOver = false
    }
}

#Preview {
    @Previewable @State var vm: NavigationHubViewModel = NavigationHubViewModel()
    @Previewable @State var scene = GameScene()
    @Previewable @StateObject var gState = GameState()
    ZStack {
        DeathScreenView(vm: $vm, scene: $scene, gameState: gState)
    }
    

}
