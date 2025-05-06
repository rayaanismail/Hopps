//
//  CameraSystem.swift
//  HoppsTestScene
//
//  Created by Rayaan Ismail on 4/22/25.
//

import Foundation
import SpriteKit

class CameraSystem: SKNode, GameSystem {
    var cameraNode: SKCameraNode = SKCameraNode()
    var altitudeLabel: SKLabelNode = SKLabelNode(text: "Altitude: 0")
    var maxCameraY: CGFloat = 0
    override init() {
        altitudeLabel.fontName = "AvenirNext-Bold"
        altitudeLabel.zPosition = 10
        altitudeLabel.horizontalAlignmentMode = .right
        super.init()
    }
    
    func update(deltaTime: TimeInterval) {
        cameraLogic()
       // print(cameraNode.position)
    }
    
    func setup(in scene: SKScene) {
        scene.addChild(self)
        scene.camera = cameraNode
        addChild(cameraNode)
        addChild(altitudeLabel)
    }
    
    /// Camera follows player as long as he is rising above the cameras center. If player falls, camera watches for when he reaches below the view, and triggers the end game scene.
    func cameraLogic() {
        if let scene = (scene as? GameScene) {
            let characterY = scene.fetchCharacter().position.y
            let camera = scene.fetchCamera()
            let cameraY = scene.fetchCamera().position.y
            let view = scene.fetchView()
            
            /// Camera follows character as long as its Y position rises above the camera.
            if characterY > cameraY {
                maxCameraY = cameraY
                camera.position.y = characterY
            }
            /// If the characters height is less than the bottom of the camera view, then restart the scene
            if characterY < (cameraY - view.halfHeight() - 50) {
                scene.restart()
            }
            
            let altitude = scene.fetchAltitude()
            altitudeLabel.text = "Altitude: \(Int(altitude))"
            altitudeLabel.position = scene.anchorPosition(0.9, 0.9)
        }
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
