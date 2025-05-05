//
//  GameScene.swift
//  HoppsTestScene
//
//  Created by Rayaan Ismail on 4/18/25.
//

import Foundation
import SpriteKit


class GameScene: SKScene, SKPhysicsContactDelegate {
    var systems = [GameSystem]()
    // All systems within the array for access
    var playerSystem: PlayerSystem?
    var backgroundSystem: BackgroundSystem?
    var cameraSystem: CameraSystem?
    var platformSystem: PlatformSystem?
    
    
    var touchSystems = [TouchControllable]()
    private var lastTime: TimeInterval = 0
    
    override func didMove(to view: SKView) {
        
        let bg = BackgroundSystem(config: BackgroundConfig(size: view.frame.size))
        let player = PlayerSystem(config: PlayerConfig(size: view.frame.size))
        let cSystem = CameraSystem()
        let pSystem = PlatformSystem(PlatformConfig())
        platformSystem = pSystem
        cameraSystem = cSystem
        playerSystem = player
        backgroundSystem = bg
        systems = [cSystem, bg, player, pSystem]
        systems.forEach {$0.setup(in: self)}
        
        // Any systems that are of the type touchcontrollable are added to this array
        touchSystems = systems.compactMap { $0 as? TouchControllable }
        physicsWorld.contactDelegate = self
        /// Offset the scenes physics body by half of the view (anchor point is 0, so this doesnt affect anything except for the collision at 0,0)
        physicsBody = SKPhysicsBody(edgeLoopFrom: physicsBodyEdgeLoop())
    }
    
    override func update(_ currentTime: TimeInterval) {
        let deltaTime = currentTime - lastTime
        systems.forEach {$0.update(deltaTime: deltaTime)}
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



