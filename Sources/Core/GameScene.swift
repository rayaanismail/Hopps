//
//  GameScene.swift
//  HoppsTestScene
//
//  Created by Rayaan Ismail on 4/18/25.
//

import Foundation
import SpriteKit
import CoreMotion

class GameScene: SKScene, SKPhysicsContactDelegate {
    // Shared game systems
    var systems       = [GameSystem]()
    var touchSystems  = [TouchControllable]()
    var sceneStartTime: TimeInterval?
    var gameTime = GameTime()
    weak var gameState: GameState?

    // These must NOT be private so everyone can access them:
    var backgroundSystem: BackgroundSystem?
    var playerSystem:     PlayerSystem?
    var cameraSystem:     CameraSystem?
    var platformSystem:   PlatformSystem?
    var enemySystem:      EnemySystem?
    var eventSystem:      EventSystem?
    var hapticSystem:     HapticSystem?
    var soundSystem:      SoundSystem?
    
    // Settings
    var touchEnabled: Bool = UserDefaults.standard.bool(forKey: "touchEnabled")
    var vibrationEnabled: Bool = UserDefaults.standard.bool(forKey: "vibrationEnabled")
    var sfxEnabled: Bool = UserDefaults.standard.bool(forKey: "sfxEnabled")

    override func didMove(to view: SKView) {
        let bg = BackgroundSystem(config: BackgroundConfig(view: view))
        let player = PlayerSystem(config: PlayerConfig(size: view.frame.size))
        let cam    = CameraSystem()
        let plat   = PlatformSystem(PlatformConfig())
        let enemy  = EnemySystem()
        let event  = EventSystem(config: EventConfig())
        let haptic = HapticSystem()
        let sound = SoundSystem(config: SoundConfig())

        // 2. Assign to your properties (all now internal)
        backgroundSystem = bg
        playerSystem     = player
        cameraSystem     = cam
        platformSystem   = plat
        enemySystem      = enemy
        eventSystem      = event
        hapticSystem     = haptic
        soundSystem      = sound
        
        // 3. Build the shared array and set them up
        systems = [cam, bg, player, plat, enemy, event, haptic, sound]
        systems.forEach { $0.setup(in: self) }

        // 4. Touch‐controllable subslice
        touchSystems = systems.compactMap { $0 as? TouchControllable }

        // 5. Physics
        physicsWorld.contactDelegate = self
        physicsBody = SKPhysicsBody(edgeLoopFrom: physicsBodyEdgeLoop())
        physicsWorld.gravity.dy *= 0.9
        self.isPaused = false
    }

    override func update(_ currentTime: TimeInterval) {
        SyncGamestate()
        guard gameState?.isPaused == false else { return }
        gameTime.update(currentTime: currentTime)
        systems.forEach { $0.update(deltaTime: gameTime.deltaTime) }
        
    }

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            guard UserDefaults.standard.bool(forKey: "touchEnabled"),
                  let pt = touches.first?.location(in: self) else { return }
            touchSystems.forEach { $0.handleTouch(at: pt, type: .began) }
        }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
            guard UserDefaults.standard.bool(forKey: "touchEnabled"),
                  let pt = touches.first?.location(in: self) else { return }
            touchSystems.forEach { $0.handleTouch(at: pt, type: .moved) }
        }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
           guard UserDefaults.standard.bool(forKey: "touchEnabled"),
                 let pt = touches.first?.location(in: self) else { return }
           touchSystems.forEach { $0.handleTouch(at: pt, type: .ended) }
       }
    
    deinit {
        
    }
}



