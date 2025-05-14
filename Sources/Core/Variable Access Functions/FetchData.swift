//
//  FetchData.swift
//  HoppsTestScene
//
//  Created by Rayaan Ismail on 5/13/25.
//

import Foundation
import SpriteKit

extension GameScene {
    // Camera Data
    func fetchCameraPosition() -> CGPoint {
        camera?.position ?? CGPoint.zero
    }
    
    func fetchCamera() -> SKCameraNode {
        return camera ?? SKCameraNode()
    }
    
    // Platform Data
    func fetchThresholdY() -> CGFloat{
        platformSystem?.spawnThresholdY ?? 0
    }
    
    // Player Data
    func fetchCharacter() -> SKNode {
        return playerSystem?.character ?? SKSpriteNode(color: .purple, size: CGSize(width: 50, height: 75))
    }
    func fetchAltitude() -> CGFloat {
        return playerSystem?.altitude ?? 0
    }
    
    // Scene Data
    func fetchView() -> SKView {
        return self.view ?? SKView.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    }
    
    /// Calculates the real coordinate position in world space from percentages of the view. Using ( 0.5 ) in both inputs will give you the a coordinate in the direct center of the screen
    func anchorPosition(_ xFactor: CGFloat, _ yFactor: CGFloat) -> CGPoint {
        let view = fetchView()
        let cameraPos = fetchCameraPosition()
        let xOffsetZero = cameraPos.x - view.halfWidth()
        let yOffsetZero = cameraPos.y - view.halfHeight()
        
        return CGPoint(
            x: xOffsetZero + (view.frame.width * xFactor),
            y: yOffsetZero + (view.frame.height * yFactor)
        )
    }
    
}
