//
//  External Access.swift
//  HoppsTestScene
//
//  Created by Rayaan Ismail on 4/29/25.
//

import Foundation
import SpriteKit

extension PlayerSystem {
    func getScene() -> GameScene {
        return (scene as? GameScene) ?? GameScene(size: CGSize.zero)
    }
    
    func getAltitude() -> CGFloat {
        (scene as? GameScene)?.fetchAltitude() ?? 0
    }
    
    func getCamera() -> SKCameraNode {
        getScene().fetchCamera()
    }
    
    func getCharacter() -> SKNode {
        getScene().fetchCharacter()
    }
    
    func getView() -> SKView {
        (scene as? GameScene)?.fetchView() ?? SKView(frame: CGRect.zero)
    }
}
