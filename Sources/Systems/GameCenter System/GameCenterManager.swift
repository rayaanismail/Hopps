//
//  GameCenterManager.swift
//  Hopps
//
//  Created by Analu Jahi on 5/23/25.
//

// GameCenterManager.swift

import UIKit
import GameKit
import SwiftUI

class GameCenterManager: NSObject, GKGameCenterControllerDelegate {
    
    static let shared = GameCenterManager()
    
    /// Call this early (e.g. in your App’s init or top-level view’s onAppear)
    func authenticateLocalPlayer() {
        let localPlayer = GKLocalPlayer.local
        localPlayer.authenticateHandler = { viewController, error in
            if let vc = viewController,
               let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               let window = windowScene.windows.first,
               let rootVC = window.rootViewController {
                rootVC.present(vc, animated: true)
            } else if localPlayer.isAuthenticated {
                print("Player authenticated: \(localPlayer.displayName)")
            } else if let error = error {
                print("Game Center authentication failed: \(error.localizedDescription)")
            } else {
//                print("Game Center authentication failed for unknown reasons.")
            }
        }
    }
    
    /// Submit a score to your leaderboard
    func submitScore(_ score: Int) {
        GKLeaderboard.submitScore(
            score,
            context: 0,
            player: GKLocalPlayer.local,
            leaderboardIDs: ["com.fivestack.hopps.highscores"]
        ) { error in
            if let error = error {
                print("Error submitting score: \(error.localizedDescription)")
            } else {
                print("Score submitted successfully!")
            }
        }
    }
    
    /// Programmatically show the Game Center leaderboard UI
    func showLeaderboard() {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first,
              let rootVC = window.rootViewController else { return }
        
        let gcVC = GKGameCenterViewController(
            leaderboardID: "com.fivestack.hopps.highscores",
            playerScope: .global,
            timeScope: .allTime
        )
        gcVC.gameCenterDelegate = self
        rootVC.present(gcVC, animated: true)
    }
    
    // MARK: - GKGameCenterControllerDelegate
    func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
        gameCenterViewController.dismiss(animated: true)
    }
}

/// SwiftUI wrapper for presenting the leaderboard
struct LeaderboardView: UIViewControllerRepresentable {
    let leaderboardID: String
    let onDone: () -> Void

    func makeUIViewController(context: Context) -> GKGameCenterViewController {
        let vc = GKGameCenterViewController(
            leaderboardID: "com.fivestack.hopps.highscores",
            playerScope: .global,
            timeScope: .allTime
        )
        vc.gameCenterDelegate = GameCenterManager.shared
        return vc
    }

    func updateUIViewController(_ uiViewController: GKGameCenterViewController, context: Context) {}

    static func dismantleUIViewController(_ uiViewController: GKGameCenterViewController, coordinator: ()) {
      
    }
}

