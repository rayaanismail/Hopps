//
//  Touch Control Protocol.swift
//  HoppsTestScene
//
//  Created by Rayaan Ismail on 4/19/25.
//

import Foundation
import SpriteKit

// Only systems that need touch input conform to this.
protocol TouchControllable {
    // Called by GameScene whenever the user touches the screen
    func handleTouch(at position: CGPoint, type: TouchType)
}

enum TouchType {
    case began, moved, ended
}
