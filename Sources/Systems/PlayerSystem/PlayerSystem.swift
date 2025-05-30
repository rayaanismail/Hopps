//
//  PlayerSystem.swift
//  HoppsTestScene
//
//  Created by Rayaan Ismail on 4/19/25.
//

import Foundation
import SpriteKit

struct PlayerConfig {
    var size: CGSize
    var playerScale: CGFloat = 0.65
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
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Updates per frame
    func update(deltaTime: TimeInterval) {
        movePlayer(deltaTime: deltaTime)
        
        
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
