//
//  PlayerSystem.swift
//  HoppsTestScene
//
//  Created by Rayaan Ismail on 4/19/25.
//

import Foundation
import SpriteKit
import CoreMotion

struct PlayerConfig {
    var size: CGSize
    var playerScale: CGFloat = 0.11
    var idleVelocityFloor: CGFloat = 25
}

class PlayerSystem: SKNode, GameSystem, TouchControllable {
    var canMove: Bool = true
    let config: PlayerConfig
    
    var altitude: CGFloat {
        get {
            return clamp(value: character.position.y, min: 0, max: CGFloat.greatestFiniteMagnitude)
        }
    }
    var character: SKSpriteNode
    var movementState: PlayerAnimationState = .idle
    
    var lastPosition: CGPoint = CGPoint.zero
    
    
    // Movement
    var targetX: CGFloat?
    var moveSpeed: CGFloat = 20
    var maxTilt: CGFloat = CGFloat(GLKMathDegreesToRadians(15))
    var tiltSmoothing: CGFloat = 0.125 // easing factor
    var previousDx: CGFloat = 0 // Remember velocity to smooth tilt more
    private var maxVelocity: CGFloat = 300
    
    var previousY: CGFloat = 0
    
    // MARK: – NEW “tilt” support
        let motionManager = CMMotionManager()
       /// Read directly from UserDefaults instead of a separate property;
       /// “touchEnabled == true” means use touch, otherwise use tilt.
        var isTouchMode: Bool {
           UserDefaults.standard.bool(forKey: "touchEnabled")
       }
    
    // Simply configures variables
    init(config: PlayerConfig) {
        self.config = config
        character = SKSpriteNode(imageNamed: "HStanding")
//        character.position = CGPoint(x: 0, y: -config.size.height / 2.5)
        character.position = CGPoint(x: 0, y: 0)
        character.setScale(config.playerScale)
        lastPosition = character.position
        super.init()
        character = playerPhysics(&character)
        
        if motionManager.isDeviceMotionAvailable {
                   motionManager.deviceMotionUpdateInterval = 1.0 / 60.0
                   motionManager.startDeviceMotionUpdates()
               }
               else if motionManager.isAccelerometerAvailable {
                   motionManager.accelerometerUpdateInterval = 1.0 / 60.0
                   motionManager.startAccelerometerUpdates()
               }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Updates per frame
    func update(deltaTime: TimeInterval) {
        if isTouchMode {
                   // existing touch‐based movement
                   movePlayer(deltaTime: deltaTime)
               } else {
                   //  tilt‐based horizontal movement
                   applyTiltMovement(deltaTime: deltaTime)
               }
        
        
        changeMovementState()
        /// If the character has reached the platforms, start limiting the speed
        if character.position.y > getPlatformThreshold() {
            clampSpeed(1350)
        }
        
        lastPosition = character.position
    }
    
    // Called in scenes didMove(to: ) NO GAME LOGIC
    func setup(in scene: SKScene) {
        scene.addChild(self)
        addChild(character)
    }
    
    // Called in scenes touch handlers.
    func handleTouch(at position: CGPoint, type: TouchType) {
        switch type {
        case .began, .moved:
            // Sets the X Position the character should move to on touch.
            targetX = position.x
            return
        case .ended:
            // do something
            return
        }
    }
    
    // Applies physics to the player node
    func playerPhysics(_ character: inout SKSpriteNode) -> SKSpriteNode {
        character.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: character.size.width * 0.5, height: character.size.height * 0.8))
        character.physicsBody?.isDynamic = true
        character.physicsBody?.allowsRotation = false
        character.physicsBody?.friction = 0.2
        character.physicsBody?.affectedByGravity = true
        character.physicsBody?.mass = 3.5
        character.physicsBody?.categoryBitMask = PhysicsCategory.character
        character.physicsBody?.collisionBitMask = PhysicsCategory.bounce
        return character
    }
    
    func applyTiltMovement(deltaTime: TimeInterval) {
            guard let body = character.physicsBody else { return }

            // Prefer DeviceMotion.attitude.roll if available; otherwise fallback to accelerometer.x
            var tiltX: Double = 0

            if let deviceMotion = motionManager.deviceMotion {
                // roll is in radians around the device’s longitudinal axis
                tiltX = deviceMotion.attitude.roll
            } else if let accelData = motionManager.accelerometerData {
                tiltX = accelData.acceleration.x
            }

            // Map “tiltX” (radians or raw accel) into a suitable velocity
            // Adjust “tiltMultiplier” until it feels natural
            let tiltMultiplier: CGFloat = 500
            let dx = CGFloat(tiltX) * tiltMultiplier

            // Set horizontal velocity, but clamp to maxVelocity:
            var newVx = dx
            if abs(newVx) > maxVelocity {
                newVx = (newVx > 0 ? 1 : -1) * maxVelocity
            }

            body.velocity.dx = newVx

            // Optionally, you can still let gravity/vertical velocity happen:
            // body.velocity.dy stays untouched.
        }
    
    func clampSpeed(_ velocity: CGFloat) {
        guard let body = character.physicsBody else { return }

            let maxSpeed: CGFloat = velocity // set your max speed
            let vx = body.velocity.dx
            let vy = body.velocity.dy

            let speed = sqrt(vx * vx + vy * vy)

            if speed > maxSpeed {
                let scale = maxSpeed / speed
                body.velocity = CGVector(dx: vx * scale, dy: vy * scale)
            }
        
        
        
    }
    
}
