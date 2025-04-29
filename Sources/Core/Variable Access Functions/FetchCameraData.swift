//
//  FetchCameraPosition.swift
//  HoppsTestScene
//
//  Created by Rayaan Ismail on 4/28/25.
//

import Foundation
import SpriteKit

extension GameScene {
    func fetchCameraPosition() -> CGPoint {
        camera?.position ?? CGPoint.zero
    }
    
    func fetchCamera() -> SKCameraNode {
        return camera ?? SKCameraNode()
    }
}
