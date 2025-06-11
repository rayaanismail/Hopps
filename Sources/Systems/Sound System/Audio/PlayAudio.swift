//
//  PlayAudio.swift
//  Hopps
//
//  Created by Rayaan Ismail on 6/6/25.
//
import Foundation
import AVFAudio
import SpriteKit

extension SoundSystem {
    func playCannonSFX() {
        guard let url = Bundle.main.url(forResource: "CannonSFX", withExtension: "wav") else { return }
        do {
            effectPlayer = try AVAudioPlayer(contentsOf: url)
            effectPlayer?.volume = config.cannonVolume
            effectPlayer?.prepareToPlay()
            effectPlayer?.play()
        } catch {
            print("Error playing cannon sound effect", error)
        }
        
        Task {
            do {
                try await Task.sleep(for: .seconds(2))
                effectPlayer = nil
            } catch {
                print("Failed to sleep after cannonSFX")
            }
        }
    }
    

    func playBackgroundTheme() {
        guard getSettings().sfxEnabled else { return }
        guard let url = Bundle.main.url(forResource: "BackgroundMusic1", withExtension: "mp3") else { return }
        do {
            backgroundMusicPlayer = try AVAudioPlayer(contentsOf: url)
            backgroundMusicPlayer?.volume = config.backgroundMusicVolume
            backgroundMusicPlayer?.prepareToPlay()
            backgroundMusicPlayer?.play()
        } catch {
            print("Error playing background music", error)
        }
    }
    
    func playAirDrag() {
        guard let url = Bundle.main.url(forResource: "AirDrag", withExtension: "wav") else { return }
        do {
            airDragPlayer = try AVAudioPlayer(contentsOf: url)
            airDragPlayer?.volume = config.airDragVolume
            airDragPlayer?.prepareToPlay()
            airDragPlayer?.numberOfLoops = -1
            airDragPlayer?.play()
            
            
        } catch {
            print("Error playing air drag", error)
        }
    }
    
    func cloudImpact(type: PlatformStyle) {
        switch type {
        default:
            self.run(SKAction.playSoundFileNamed("LandImpact.wav", waitForCompletion: true))
            
        }
    }
}
