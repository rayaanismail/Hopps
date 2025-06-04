//
//  Sound System.swift
//  Hopps
//
//  Created by Rayaan Ismail on 6/6/25.
//

import Foundation
import SpriteKit
import AVFAudio

class SoundSystem: SKNode, GameSystem {
    let config: SoundConfig
    
    init(config: SoundConfig) {
        self.config = config
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(deltaTime: TimeInterval) {
        
    }
    
    func setup(in scene: SKScene) {
        scene.addChild(self)
        
    }
    
    func playCannonExplosion(_ cannon: inout SKSpriteNode) {
        let sound = SKAction.playSoundFileNamed("cannonsfx.wav", waitForCompletion: false)
        self.run(sound)
    }
    
}
