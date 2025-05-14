//
//  FetchSceneData.swift
//  HoppsTestScene
//
//  Created by Rayaan Ismail on 4/28/25.
//

import Foundation
import SpriteKit

extension GameScene {
    func fetchView() -> SKView {
        return self.view ?? SKView.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    }
    
    /// Calculates the real coordinate position in world space from percentages of the view. Using ( 0.5 ) in both inputs will give you the a coordinate in the direct center of the screen
    func anchorPosition(_ xFactor: CGFloat, _ yFactor: CGFloat) -> CGPoint {
        let view = fetchView()
        let cameraPos = fetchCameraPosition()
        let xOffsetZero = cameraPos.x - view.halfWidth()
     //   let xPositiveZero = cameraPos.x + view.halfWidth()
        let yOffsetZero = cameraPos.y - view.halfHeight()
        
        return CGPoint(
            x: xOffsetZero + (view.frame.width * xFactor),
            y: yOffsetZero + (view.frame.height * yFactor)
        )
    }
}
