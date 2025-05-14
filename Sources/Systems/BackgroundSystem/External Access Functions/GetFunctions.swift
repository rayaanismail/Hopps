//
//  GetFunctions.swift
//  HoppsTestScene
//
//  Created by Rayaan Ismail on 4/28/25.
//

import Foundation
import SpriteKit

extension BackgroundSystem {
    /// Fetches the event system GameScene, call fetch functions to access data.
    func getScene() -> GameScene {
        return (scene as? GameScene) ?? GameScene(size: CGSize.zero)
    }
    
    func getAltitude() -> CGFloat {
        getScene().fetchAltitude()
    }
    
    func getCameraPosition() -> CGPoint {
        getScene().fetchCameraPosition()
    }
    
    
}
