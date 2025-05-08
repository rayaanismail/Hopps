//
//  AnimationManager.swift
//  HoppsTestScene
//
//  Created by Rayaan Ismail on 5/6/25.
//

import Foundation
import SpriteKit

final class AnimationManager {
    /// Cage Break Animation, derived from a Spritesheet
    static let cageJump: SKAction = {
        // Create an array of SKTextures from texture atlas / spritesheet
        let sheet = SpriteSheet(texture: SKTexture(imageNamed: "CageAnimation"), rows: 1, columns: 4)
        var frames = [SKTexture]()
        for column in 0..<4 {
            if let texture = sheet.textureForColumn(column: column, row: 0) {
                frames.append(texture)
            }
        }
        // return animation created from the texture array, with a configurable time per frame
        let animation = SKAction.animate(with: frames, timePerFrame: 0.13)
        return animation
    }()
    
    static let jumpAnimation: SKAction = {
        var frames = getSpritesheet(imageNamed: "HoppsJumpAnimation", rows: 1, columns: 4)
        frames.append(SKTexture(image: .hStanding))
        let animation = SKAction.animate(with: frames, timePerFrame: 0.13)
        return animation
    }()
    
    /// The initial texture for the cage break animation spritesheet
    static let cageTexture: SKTexture = {
        let sheet = SpriteSheet(texture: SKTexture(imageNamed: "CageAnimation"), rows: 1, columns: 4)
        return sheet.textureForColumn(column: 0, row: 0)!
    }()
    
    
}

/// Returns a SKTexture Array for spritesheets
func getSpritesheet(imageNamed: String, rows: Int, columns: Int) -> [SKTexture] {
    let sheet = SpriteSheet(texture: SKTexture(imageNamed: imageNamed), rows: rows, columns: columns)
    var frames = [SKTexture]()
    for column in 0..<columns {
        if let texture = sheet.textureForColumn(column: column, row: 0) {
            frames.append(texture)
        }
    }
    
    return frames
}

// Ensure the player has an idle animation (breathing)
