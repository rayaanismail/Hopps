//
//  GameState.swift
//  Hopps
//
//  Created by Rayaan Ismail on 5/29/25.
//

import Foundation
import SwiftUI

///  Observable class that binds to the scene and shares data between the UI and SKScene
class GameState: ObservableObject {
    @Published var isPaused = false
    @Published var isGameOver = false
    @Published var score = 0
    @Published var scenesCreated = 0
}
