//
//  GetFunctions.swift
//  HoppsTestScene
//
//  Created by Rayaan Ismail on 4/28/25.
//

import Foundation
import SpriteKit

extension BackgroundSystem {
    func getAltitude() -> CGFloat {
        (scene as? GameScene)?.fetchAltitude() ?? 0
    }
    
    func getCameraPosition() -> CGPoint {
        (scene as? GameScene)?.fetchCameraPosition() ?? CGPoint.zero
    }

}
