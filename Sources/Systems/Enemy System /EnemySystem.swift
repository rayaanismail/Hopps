//
//  EnemySystem.swift
//  HoppsTestScene
//
//  Created by Analu Jahi on 5/19/25.

import SpriteKit

/// Orchestrates spawning, updating, and cleanup of all enemy types.
final class EnemySystem: SKNode, GameSystem {
    /// Single tracker instance that homes in on the player.
    var tracker: TrackerEnemy?
    /// Array of active zig-zag enemies.
    var zigzags: [ZigzagEnemy] = []
    /// Accumulates time to know when to spawn the next zig-zag.
    var zigzagTimer: TimeInterval = 0

    /// Maximum allowed zig-zag enemies at once.
    let maxZigzagEnemies = 5
    /// Interval (in seconds) between zig-zag spawns.
    let zigzagInterval: TimeInterval = 2.0

    /// Adds this system as a child of the given scene.
    func setup(in scene: SKScene) {
        scene.addChild(self)
    }

    /// Called each frame: handles spawning, updating, and cleanup.
    /// - Parameter deltaTime: Time elapsed since last update.
    func update(deltaTime: TimeInterval) {
        // Ensure we have a GameScene and its SKView.
        guard let gs = scene as? GameScene, let view = gs.view else { return }

        // ─── Tracker spawning and update ─────────────────────
        if tracker == nil {
            let t = TrackerEnemy()
            let spawnPos = calculateTrackerSpawn(in: gs, view: view)
            t.spawn(at: spawnPos)
            addChild(t.node)
            tracker = t
        }
        tracker?.update(deltaTime: deltaTime, in: gs)

        // ─── Zig-zag spawning ───────────────────────────────
        zigzagTimer += deltaTime
        if zigzagTimer >= zigzagInterval {
            zigzagTimer = 0
            if zigzags.count < maxZigzagEnemies {
                let z = ZigzagEnemy()
                let spawnPos = calculateZigzagSpawn(in: gs)
                z.spawn(at: spawnPos, in: gs)
                addChild(z.node)
                zigzags.append(z)
            }
        }

        // ─── Cleanup off-screen zig-zags ───────────────────
        let bottomY = gs.anchorPosition(0.5, 0).y - (zigzags.first?.node.frame.height ?? 5)
        zigzags.removeAll { zig in
            if zig.node.position.y < bottomY {
                zig.node.removeFromParent()
                return true
            }
            return false
        }
    }

    // MARK: — Spawn Helpers

    /// Calculates a spawn point for the tracker just off the bottom of the camera's view.
    func calculateTrackerSpawn(in gs: GameScene, view: SKView) -> CGPoint {
        let cam   = gs.fetchCameraPosition()
        let halfW = view.frame.width  / 2
        let halfH = view.frame.height / 2
        // Randomly choose left or right edge
        let x = Bool.random()
            ? cam.x - halfW - 2.5
            : cam.x + halfW + 2.5
        // Position well below the bottom edge
        let y = cam.y - halfH - 1500
        return CGPoint(x: x, y: y)
    }

    /// Calculates a spawn point for a zig-zag enemy just above the top of the camera's view.
    func calculateZigzagSpawn(in gs: GameScene) -> CGPoint {
        let minX = gs.anchorPosition(0, 0).x + 2.5
        let maxX = gs.anchorPosition(1, 0).x - 2.5
        let x    = CGFloat.random(in: minX...maxX)

        let cam   = gs.fetchCameraPosition()
        let halfH = (gs.view?.frame.height ?? 0) / 2
        // Position well above the top edge
        let y     = cam.y + halfH + 1500

        return CGPoint(x: x, y: y)
    }
}

