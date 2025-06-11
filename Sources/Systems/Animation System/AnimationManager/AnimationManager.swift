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
    static let launchAnimation: SKAction = {
        // Create an array of SKTextures from texture atlas / spritesheet
        var frames = getSpritesheet(imageNamed: "CannonAnimation", rows: 1, columns: 9, spacing: 0, margin: 0)
        // return animation created from the texture array, with a configurable time per frame
        let animation = SKAction.animate(with: frames, timePerFrame: 0.09)
        return animation
    }()
    
    static let launchEffectAnimation: SKAction = {
        var frames = getSpritesheet(imageNamed: "CannonSmokeAnimation", rows: 1, columns: 4)
        return SKAction.animate(with: frames, timePerFrame: 0.18)
    }()
    
//    static let jumpAnimation: SKAction = {
//        var frames = getSpritesheet(imageNamed: "HoppsJumpAnimation", rows: 1, columns: 4)
//        frames.append(SKTexture(image: .hStanding))
//        let animation = SKAction.animate(with: frames, timePerFrame: 0.13)
//        return animation
//    }()
    
    /// The initial texture for the cage break animation spritesheet
    static let launchTexture: SKTexture = {
        let sheet = SpriteSheet(texture: SKTexture(imageNamed: "CannonAnimation"), rows: 1, columns: 9)
        return sheet.textureForColumn(column: 0, row: 0)!
    }()
    /// Animation that flops ears down simulating vertical ascent
    static let ascendingAnimation: SKAction = {
        let frames = getSpritesheet(imageNamed: "AscendingAnimation", rows: 1, columns: 4)
        return SKAction.animate(with: frames, timePerFrame: 0.049)
    }()
    
    static let ascendingSpaceAnimation: SKAction = {
        let frames = getSpritesheet(imageNamed: "AscendSpaceAnimation", rows: 1, columns: 4)
        return SKAction.animate(with: frames, timePerFrame: 0.049)
    }()
    
    static let jumpAnimation: SKAction = {
        let sheets = getSpritesheet(imageNamed: "JumpAnimation", rows: 1, columns: 5)
        return SKAction.animate(with: sheets, timePerFrame: 0.10)
    }()
    /// Animation that flops ears and opens arms for vertical descent
    static let descendingAnimation: SKAction = {
        let sheet = getSpritesheet(imageNamed: "DescendingAnimation", rows: 1, columns: 3)
        return SKAction.animate(with: sheet, timePerFrame: 0.065)
    }()
    
    static let descendingSpaceAnimation: SKAction = {
        let sheet = getSpritesheet(imageNamed: "DescendSpaceAnimation", rows: 1, columns: 3)
        return SKAction.animate(with: sheet, timePerFrame: 0.065)
    }()
    
    static let equipSpaceSuitAnimation: SKAction = {
       let sheet = getSpritesheet(imageNamed: "EquipSpaceSuitAnimation", rows: 1, columns: 6)
        return SKAction.animate(with: sheet, timePerFrame: 0.25)
    }()
    static let alienAnimation: SKAction = {
        let sheet = getSpritesheet(imageNamed: "AlienAnimation", rows: 1, columns: 8)
        return SKAction.animate(with: sheet, timePerFrame: 0.05)
    }()
    /// Animation that flaps the eagles wings to show flying
    static let trackerAnimation: SKAction = {
        let frame = getSpritesheet(imageNamed: "EBirdAnimation", rows: 1, columns: 11)
        return SKAction.animate(with: frame, timePerFrame: 0.05)
    }()
    /// Animation that flaps the regualr birds to flying 
    static let zigzagAnimation: SKAction = {
        let frame = getSpritesheet(imageNamed: "RBirdAnimation", rows: 1, columns: 11)
        return SKAction.animate(with: frame, timePerFrame: 0.05)
    }()
    
}

/// Returns a SKTexture Array for spritesheets
func getSpritesheet(imageNamed: String, rows: Int, columns: Int, spacing: CGFloat = 0, margin: CGFloat = 0) -> [SKTexture] {
    let sheet = SpriteSheet(texture: SKTexture(imageNamed: imageNamed), rows: rows, columns: columns, spacing: spacing, margin: margin)
    var frames = [SKTexture]()
    for column in 0..<columns {
        if let texture = sheet.textureForColumn(column: column, row: 0) {
            frames.append(texture)
        }
    }
    
    return frames
}

// Ensure the player has an idle animation (breathing)
