//
//  CharacterControlRotation.swift
//  HoppsTestScene
//
//  Created by Rayaan Ismail on 4/18/25.
//

import Foundation
import SpriteKit

class ControlRotationTest: SKScene {
    var character: SKSpriteNode?
    
    override func didMove(to view: SKView) {
        setupCharacter(view)
    }
    
    override func update(_ currentTime: TimeInterval) {
        // do code
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        
//        character?.position.x = location.x
        moveCharacter(toX: location.x)
    }
}

extension ControlRotationTest {
    func setupCharacter(_ view: SKView) {
        character = SKSpriteNode(color: .white, size: CGSize(width: 50, height: 50 * 1.5))
        character?.position = CGPoint(x: view.frame.midX, y: view.frame.midY)
        addChild(character!)
    }
    
    func moveCharacter(toX xPos: CGFloat) {
        guard let character = character else { return }
        let duration = 0.5 /// Adjust for speed
        let tiltAngle: CGFloat = 0.2 /// Radians, adjust for how much tilt
        
        let direction: CGFloat = xPos > character.position.x ? -1 : 1 /// If xPos greater than character x, set the direction to be positive or negative.
        let tiltAction = SKAction.rotate(toAngle: direction * tiltAngle, duration: 0.1, shortestUnitArc: true)
        tiltAction.timingMode = .easeIn
        let moveAction = SKAction.moveTo(x: xPos, duration: duration)
        let straightenAction = SKAction.rotate(toAngle: 0, duration: 0.1)
        let sequence = SKAction.sequence([tiltAction, moveAction, straightenAction])
        character.run(sequence)
    }
}
