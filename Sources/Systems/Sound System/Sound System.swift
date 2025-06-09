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
    var effectPlayer: AVAudioPlayer?
    var backgroundMusicPlayer: AVAudioPlayer?
    
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
    /// De-allocates and undoes the setup required for all playback players.
    func deallocatePersistentAudio() {
        backgroundMusicPlayer?.stop()
        effectPlayer?.stop()
    }
    /// Pauses persistent audio and saves the progress
    func pausePersistentAudio(_ state: Bool) {
        if state {
            backgroundMusicPlayer?.pause()
            effectPlayer?.pause()
        } else {
            backgroundMusicPlayer?.play()
            effectPlayer?.play()
        }
    }
}


