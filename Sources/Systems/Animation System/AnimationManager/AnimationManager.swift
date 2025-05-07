//
//  AnimationManager.swift
//  HoppsTestScene
//
//  Created by Rayaan Ismail on 5/6/25.
//

import Foundation
import SpriteKit

final class AnimationManager {
    /// Cage Jump Animation, derived from a Spritesheet
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
}

// Ensure the player has an idle animation (breathing)
