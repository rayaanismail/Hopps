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
    var players = [AVAudioPlayer?]()
    var effectPlayer: AVAudioPlayer?
    var backgroundMusicPlayer: AVAudioPlayer?
    var airDragPlayer: AVAudioPlayer?
    var ambienceTimer: Timer?
    var ambiencePlayer: AVAudioPlayer?
    var ambiencePlayer2: AVAudioPlayer?
    var gameTime: GameTime {
        getScene().gameTime
    }
    
    init(config: SoundConfig) {
        self.config = config
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(deltaTime: TimeInterval) {

        if gameTime.elapsedTime == 0 {
//            print("Elapsed time is zero playing ambience and airdrag")
            backgroundMusicPlayer = nil
            ambiencePlayer = nil
            playAirDrag()
            playTreeAmbience()
            
        } else {
            updateVelocityAudio()
//            transitionAmbienceVolumes()
            pausePersistentAudio(false)
        }
        
    }
    
    func setup(in scene: SKScene) {
        scene.addChild(self)
        players = [effectPlayer, backgroundMusicPlayer, airDragPlayer, ambiencePlayer]
        playTreeAmbience()
        playCloudAmbience()
        startAmbienceTimer()
    }
    /// De-allocates and undoes the setup required for all playback players.
    func deallocatePersistentAudio() {
        airDragPlayer?.stop()
        airDragPlayer = nil
//        print("Players before stopping: \(players)")
        for i in 0..<players.count {
            players[i]?.stop()
            players[i] = nil
        }
        resetPersistentAudio()
//        print("Players after stopping: \(players)")
    }
    /// Pauses persistent audio and saves the progress
    func pausePersistentAudio(_ state: Bool) {
        
        if state {
            effectPlayer?.stop()
            airDragPlayer?.stop()
            backgroundMusicPlayer?.stop()
            ambiencePlayer?.stop()
            ambiencePlayer2?.stop()
        } else {
            effectPlayer?.play()
            airDragPlayer?.play()
            backgroundMusicPlayer?.play()
            ambiencePlayer?.play()
            ambiencePlayer2?.play()
        }
    }
    
    func resetPersistentAudio() {
        effectPlayer = nil
        airDragPlayer = nil
        backgroundMusicPlayer = nil
        ambiencePlayer = nil
        ambiencePlayer2 = nil
    }
    
    func updateVelocityAudio() {
        var velocity = getScene().fetchCharacter().physicsBody?.velocity.dy ?? 850
        velocity = abs(velocity)
        velocity /= 23000
        airDragPlayer?.volume = Float(min(velocity, CGFloat(config.airDragVolume)))
    }
    
    func startAmbienceTimer() {
        ambienceTimer?.invalidate() // Just in case
        ambienceTimer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { [weak self] _ in
            self?.transitionAmbienceVolumes()
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


