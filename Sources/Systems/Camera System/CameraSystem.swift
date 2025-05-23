//
//  CameraSystem.swift
//  HoppsTestScene
//
//  Created by Rayaan Ismail on 4/22/25.
//

import Foundation
import SpriteKit
import GameKit

class CameraSystem: SKNode, GameSystem {
    var cameraNode: SKCameraNode = SKCameraNode()
    var altitudeLabel: SKLabelNode = SKLabelNode(text: "0")
    var maxCameraY: CGFloat = 0

    override init() {
        altitudeLabel.fontName = "AvenirNext-Bold"
        altitudeLabel.zPosition = 10
        altitudeLabel.horizontalAlignmentMode = .left
        altitudeLabel.fontColor = .black
        super.init()
    }

    func setup(in scene: SKScene) {
        scene.addChild(self)
        scene.camera = cameraNode
        addChild(cameraNode)
        addChild(altitudeLabel)
    }

    func update(deltaTime: TimeInterval) {
        cameraLogic()
    }

    /// Camera follows player as long as he is rising above the camera’s center.
    /// If player falls below the bottom of the view, submit score and restart.
    func cameraLogic() {
        guard let scene = (scene as? GameScene) else { return }

        let characterY = scene.fetchCharacter().position.y
        let cameraY = scene.fetchCamera().position.y
        let view = scene.fetchView()

        // Follow upward movement
        if characterY > cameraY {
            maxCameraY = cameraY
            scene.fetchCamera().position.y = characterY
        }

        // Check for fall below view bottom -> end run
        if characterY < (cameraY - view.halfHeight() - 50) {
            // Grab final altitude and submit to Game Center
            let finalAltitude = scene.fetchAltitude()
            GameCenterManager.shared.submitScore(Int(finalAltitude))

            // Restart the scene
            scene.restart()
        }

        // Update altitude label every frame
        let altitude = scene.fetchAltitude()
        altitudeLabel.text = "\(Int(altitude))"
        altitudeLabel.position = scene.anchorPosition(0.1, 0.9)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
