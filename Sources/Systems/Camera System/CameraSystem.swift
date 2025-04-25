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
    var trackingY: CGFloat = 0
    var altitudeLabel: SKLabelNode = SKLabelNode(text: "Altitude: 0")
    
    override init() {
        altitudeLabel.zPosition = 10
        super.init()
    }
    // Camera should not move unless player is above the tracking Y
    // Background should 'follow' camera, to look static
    
    
    func update(deltaTime: TimeInterval) {
        guard let scene = (scene as? GameScene) else {return}
        guard let altitude = scene.playerSystem?.altitude else { return }
        if let character = scene.playerSystem?.character {
            guard let origin = scene.camera?.frame.origin else {return}
            
            if altitude > trackingY && altitude > cameraNode.frame.midY{
                cameraNode.position.y = altitude
            } else if altitude < origin.y - 400{
                print(origin)

                scene.restart()
            }
//            print("Character is below threshold of \(trackingY)")
        }
        altitudeLabel.text = "Altitude \(altitude.rounded())"
        altitudeLabel.position = getAltitudeLabelPosition(scene: scene)
        
        
        
    }
    
    func setup(in scene: SKScene) {
        scene.addChild(self)
        scene.camera = cameraNode
        addChild(cameraNode)
        addChild(altitudeLabel)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func getAltitudeLabelPosition(scene: SKScene) -> CGPoint {
        guard let viewFrame = scene.view?.frame else { return CGPoint.zero}
        let xOffset = (viewFrame.width / 3) * 0.7
        let yOffset = (viewFrame.height / 2) * 0.8
        let xPos = (scene.camera?.position.x ?? 0) + xOffset
        let yPos = (scene.camera?.position.y ?? 0) + yOffset
        return CGPoint(x: xPos, y: yPos)
    }
}
