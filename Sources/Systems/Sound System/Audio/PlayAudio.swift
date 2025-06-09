//
//  PlayAudio.swift
//  Hopps
//
//  Created by Rayaan Ismail on 6/6/25.
//
import Foundation
import AVFAudio

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
    }
    
    func playBackgroundTheme() {
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
}
