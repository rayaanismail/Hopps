//
//  EnemySystem.swift
//  HoppsTestScene
//
//  Created by Analu Jahi on 5/19/25.

import Foundation
import SpriteKit

/// Manages one “smart” tracker plus many periodic zig-zag enemies
class EnemySystem: SKNode, GameSystem {
    // MARK: — Properties

    /// Tracks previous horizontal delta for tilt
    var previousDx: CGFloat = 0
    
    /// Maximum tilt angle in radians
    let maxTilt: CGFloat = CGFloat(GLKMathDegreesToRadians(90))
    
    /// Smoothing factor for tilt interpolation
    let tiltSmoothing: CGFloat = 0.125

    /// Cap for simultaneous zig-zag enemies
    let maxZigzagEnemies = 5

    /// The single tracking bird (nil until spawned)
    var tracker: SKSpriteNode?

    /// All currently live zig-zag birds
    var zigzags: [SKSpriteNode] = []

    /// Accumulates time to know when to emit next zig-zag
    var zigzagTimer: TimeInterval = 0

    /// How often (seconds) to spawn a new zig-zag
    let zigzagInterval: TimeInterval = 3.0

    /// Chase speed for the tracker
    let chaseSpeed: CGFloat = 500

    /// Zig-zag travel distance
    let zigzagDistance: CGFloat = 100

    /// Physics/body size for all birds
    let enemySize = CGSize(width: 5, height: 5)

    // MARK: — Setup

    /// Call from GameScene.didMove(to:)
    func setup(in scene: SKScene) {
        scene.addChild(self)
    }

    // MARK: — GameSystem

    func update(deltaTime: TimeInterval) {
        let dt = CGFloat(deltaTime)

        guard let gs = self.scene as? GameScene,
              let view = gs.view
        else { return }

        // ─── 1) Spawn & steer the single tracker ────────────────────
        if tracker == nil {
            spawnTracker(in: gs, view: view)
        } else {
            steer(tracker!, toward: gs.fetchCharacter() as! SKSpriteNode, dt: dt)
        }

        // ─── 2) Periodically spawn zig-zag enemies ─────────────────
        zigzagTimer += deltaTime
        if zigzagTimer >= zigzagInterval {
            zigzagTimer = 0
            if zigzags.count < maxZigzagEnemies {
                spawnZigzag(in: gs)
            }
        }

        // ─── 3) Clean up any zig-zags that fell below the bottom ─────
        let bottomY = gs.anchorPosition(0.5, 0.0).y - enemySize.height
        for (i, z) in zigzags.enumerated().reversed() {
            if z.position.y < bottomY {
                z.removeFromParent()
                zigzags.remove(at: i)
            }
        }
    }

    // MARK: — Spawning

    func spawnTracker(in gs: GameScene, view: SKView) {
        let e = SKSpriteNode(imageNamed: "EBirdEnemy")
        e.setScale(1.4)
        e.physicsBody = SKPhysicsBody(rectangleOf: enemySize)
        e.physicsBody?.isDynamic = false
        e.physicsBody?.categoryBitMask    = PhysicsCategory.enemy
        e.physicsBody?.contactTestBitMask = PhysicsCategory.character

        // bottom-left or bottom-right just off-screen
        let cam = gs.fetchCameraPosition()
        let halfW = view.frame.width  / 2
        let halfH = view.frame.height / 2
        let left  = CGPoint(x: cam.x - halfW, y: cam.y - halfH)
        let right = CGPoint(x: cam.x + halfW, y: cam.y - halfH)

        let spawnX = Bool.random()
            ? left.x  - enemySize.width/2
            : right.x + enemySize.width/2
        // optional vertical offset if desired
        let spawnY = left.y - enemySize.height/2 - 800

        e.position = CGPoint(x: spawnX, y: spawnY)
     //   e.zRotation = -.pi / 2
        addChild(e)
        tracker = e

        print("🎯 Tracker spawned at \(e.position), camera at \(cam)")
    }

    func spawnZigzag(in gs: GameScene) {
        let z = SKSpriteNode(imageNamed: "RBirdEnemy")
        z.setScale(0.2)
        z.physicsBody = SKPhysicsBody(rectangleOf: enemySize)
        z.physicsBody?.isDynamic = false
        z.physicsBody?.categoryBitMask    = PhysicsCategory.enemy
        z.physicsBody?.contactTestBitMask = PhysicsCategory.character

        // ─── horizontal range ───────────────────────────────────────
        let minX   = gs.anchorPosition(0.0, 0.0).x + enemySize.width/2
        let maxX   = gs.anchorPosition(1.0, 0.0).x - enemySize.width/2
        let spawnX = CGFloat.random(in: minX...maxX)

        // ─── vertical spawn just off-screen above the top edge ──────
        let cam      = gs.fetchCameraPosition()
        let halfH    = gs.view!.frame.height / 2
        let topEdgeY = cam.y + halfH
        // add 20 points of padding so it starts fully out of view
        let spawnY   = topEdgeY + enemySize.height/2 + 1500

        z.position = CGPoint(x: spawnX, y: spawnY)
        addChild(z)
        zigzags.append(z)

        // ─── constrain to horizontal bounds ─────────────────────────
        let xRange = SKRange(lowerLimit: minX, upperLimit: maxX)
        z.constraints = [ SKConstraint.positionX(xRange) ]

        // ─── give it its classic zig-zag motion ────────────────────
        let dur = Double.random(in: 1.5...3.0)
        let action: SKAction
        if Bool.random() {
            // horizontal zigzag: flip at each turn
            let faceRight = SKAction.run { z.xScale = abs(z.xScale) }
            let faceLeft  = SKAction.run { z.xScale = -abs(z.xScale) }
            action = .sequence([
                faceRight,
                .moveBy(x: -zigzagDistance, y: 0, duration: dur),
                faceLeft,
                .moveBy(x: zigzagDistance, y: 0, duration: dur)
            ])
        } else {
            // vertical zigzag: keep last horizontal facing
            let moveDown = SKAction.moveBy(x: 0, y: -zigzagDistance, duration: dur)
            let moveUp   = SKAction.moveBy(x: 0, y: zigzagDistance,  duration: dur)
            action = .sequence([moveDown, moveUp])
        }
        z.run(.repeatForever(action))

        print("🎉 Zigzag spawned at \(z.position)")
    }

    // MARK: — Steering

    func steer(_ e: SKSpriteNode, toward character: SKSpriteNode, dt: CGFloat) {
        // 1) move as you already do…
        let dx   = character.position.x - e.position.x
        let dy   = character.position.y - e.position.y
        let dist = hypot(dx, dy)
        guard dist > 0 else { return }
        let maxStep = chaseSpeed * dt
        let step    = min(dist, maxStep)
        e.position.x += dx / dist * step
        e.position.y += dy / dist * step

        // 2) compute the angle to the player…
        let rawAngle = atan2(dy, dx)

        // 3) if your art faces right by default, you can just do:
        e.zRotation = rawAngle + .pi

        //    ——— OR ———
        // if it faces up (+y) by default, subtract π/2:
        // e.zRotation = angle - .pi/2

        // 4) (optional) smooth it:
        // let smoothed = lerp(from: e.zRotation, to: angle, amount: tiltSmoothing)
        // e.zRotation = smoothed

        // clamp horizontally within camera bounds
        if let gs = scene as? GameScene {
            let minX = gs.anchorPosition(0.0, 0.0).x + enemySize.width/2
            let maxX = gs.anchorPosition(1.0, 0.0).x - enemySize.width/2
            e.position.x = clamp(value: e.position.x, min: minX, max: maxX)
        }
    }

    // MARK: — Helpers

    func clamp(value: CGFloat, min: CGFloat, max: CGFloat) -> CGFloat {
        return value < min ? min : (value > max ? max : value)
    }

    func lerp(from: CGFloat, to: CGFloat, amount: CGFloat) -> CGFloat {
        return from + (to - from) * amount
    }
}
