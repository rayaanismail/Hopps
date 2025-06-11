//
//  PlayerAnimationState.swift
//  HoppsTestScene
//
//  Created by Rayaan Ismail on 5/16/25.
//

import Foundation
import SpriteKit

extension PlayerSystem {
    enum PlayerAnimationState {
        case idle, ascending, descending, bouncing, boosting
    }
    /// Switches animations based on the players movement
    func changeMovementState() {
        guard let dy = character.physicsBody?.velocity.dy else { return }
        /// Do not change state until jump animation is finished
        guard character.action(forKey: "jump") == nil else { return }
        guard character.action(forKey: "equippingSpaceSuit") == nil else { return }
        /// Only applies animation when state changes
        let newState: PlayerAnimationState
        if dy > config.idleVelocityFloor {
            newState = .ascending
        } else if dy < -config.idleVelocityFloor {
            newState = .descending
        } else {
            newState = .idle
        }
        
        if newState != movementState {
            movementState = newState
            if !inSpace {
                switch movementState {
                case .descending:
                    character.setScale(config.playerScale)
                    character.removeAllActions()
                    character.run(.repeatForever(AnimationManager.descendingAnimation), withKey: "descending")
                case .ascending:
                    character.setScale(config.playerScale)
                    character.removeAllActions()
                    character.run(.repeatForever(AnimationManager.ascendingAnimation))
                default:
                    character.setScale(config.playerScale)
                    character.removeAllActions()
                    character.texture = SKTexture(image: .hStanding)
                }
            } else {
                switch movementState {
                case .descending:
                    character.setScale(config.playerScale * 1.1)
                    character.removeAllActions()
                    character.run(.repeatForever(AnimationManager.descendingSpaceAnimation), withKey: "descending")
                case .ascending:
                    character.setScale(config.playerScale * 1.1)
                    character.removeAllActions()
                    character.run(.repeatForever(AnimationManager.ascendingSpaceAnimation))
                default:
                    character.setScale(config.playerScale * 1.1)
                    character.removeAllActions()
                    character.texture = SKTexture(image: .spaceStanding)
                }
            }
        }
        
        /// If player is falling, switch his state & animate him falling forever ONCE until his state changes
        if movementState == .descending && (character.action(forKey: "descending") == nil) {
            character.removeAllActions()
            
        }
        
        // If player is rising, switch his state & animate him falling forever ONCE, until his state changes
    }
}
