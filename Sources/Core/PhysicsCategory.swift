//
//  PhysicsCategory.swift
//  HoppsTestScene
//
//  Created by Rayaan Ismail on 4/22/25.
//

import Foundation

struct PhysicsCategory {
    static let character: UInt32 = 0x1 << 0 // 1
    static let bounce: UInt32 = 0x1 << 1 // 2
    static let enemy: UInt32 = 0x1 << 2 // 4
}
