//
//  GameScene.swift
//  HoppsTestScene
//
//  Created by Rayaan Ismail on 4/18/25.
//

import Foundation
import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    // Shared game systems
    var systems       = [GameSystem]()
    var touchSystems  = [TouchControllable]()
    private var lastTime: TimeInterval = 0
    
    // These must NOT be private so everyone can access them:
    var backgroundSystem: BackgroundSystem?
    var playerSystem:     PlayerSystem?
    var cameraSystem:     CameraSystem?
    var platformSystem:   PlatformSystem?
    var enemySystem:      EnemySystem?

    override func didMove(to view: SKView) {
        
        let bg = BackgroundSystem(config: BackgroundConfig(size: view.frame.size))
        let player = PlayerSystem(config: PlayerConfig(size: view.frame.size))
        let cam    = CameraSystem()
        let plat   = PlatformSystem(PlatformConfig())
        let enemy = EnemySystem()

        // 2. Assign to your properties (all now internal)
        backgroundSystem = bg
        playerSystem     = player
        cameraSystem     = cam
        platformSystem   = plat
        enemySystem      = enemy

        // 3. Build the shared array and set them up
        systems = [enemy, cam, bg, player, plat]
        systems.forEach { $0.setup(in: self) }

        // 4. Touch‐controllable subslice
        touchSystems = systems.compactMap { $0 as? TouchControllable }

        // 5. Physics
        physicsWorld.contactDelegate = self
        physicsBody = SKPhysicsBody(edgeLoopFrom: physicsBodyEdgeLoop())
    }

    override func update(_ currentTime: TimeInterval) {
        let deltaTime = currentTime - lastTime
        systems.forEach { $0.update(deltaTime: deltaTime) }
        lastTime = currentTime
    }

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let pt = touches.first?.location(in: self) else { return }
        touchSystems.forEach { $0.handleTouch(at: pt, type: .began) }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let pt = touches.first?.location(in: self) else { return }
        touchSystems.forEach { $0.handleTouch(at: pt, type: .moved) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let pt = touches.first?.location(in: self) else { return }
        touchSystems.forEach { $0.handleTouch(at: pt, type: .ended) }
    }
    
    }



