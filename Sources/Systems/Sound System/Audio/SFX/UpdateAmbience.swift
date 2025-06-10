//
//  UpdateAmbience.swift
//  Hopps
//
//  Created by Rayaan Ismail on 6/9/25.
//

import Foundation
import AVFAudio
import SpriteKit

extension SoundSystem {
    func playTreeAmbience() {
        guard let url = Bundle.main.url(forResource: "TreeAmbience", withExtension: "mp3") else { return }
        do {
            ambiencePlayer = try AVAudioPlayer(contentsOf: url)
            ambiencePlayer?.volume = config.ambienceVolume
            ambiencePlayer?.prepareToPlay()
            ambiencePlayer?.numberOfLoops = -1
            ambiencePlayer?.play()
            
            
        } catch {
            print("Error playing ambient tree", error)
            //            ambiencePlayer?.stop()
        }
    }
    
    func playCloudAmbience() {
        guard let url = Bundle.main.url(forResource: "CloudAmbience", withExtension: "mp3") else { return }
        do {
            ambiencePlayer2 = try AVAudioPlayer(contentsOf: url)
            ambiencePlayer2?.volume = 0
            ambiencePlayer2?.prepareToPlay()
            ambiencePlayer2?.numberOfLoops = -1
            ambiencePlayer2?.play()
            
            
        } catch {
            print("Error playing ambient tree", error)
            //            ambiencePlayer?.stop()
        }
    }
    
    func transitionAmbienceVolumes() {
        let firstStage = ProgressionManager().stageOne
        let minimumElevation = firstStage.range.upperBound - (config.transitionDistance / 2)
        let maximumElevation = minimumElevation + config.transitionDistance
//        print("\(getScene().fetchAltitude()) :><: \(maximumElevation)")
        guard getScene().fetchAltitude() < maximumElevation else {
            print("Step 1")
            if ambiencePlayer?.volume != 0 && ambiencePlayer2?.volume != config.ambienceVolume {
                print("Definitely needs fixing.")
                ambiencePlayer?.volume = 0
                
                ambiencePlayer2?.volume = config.ambienceVolume
            }
            return }
        
        if getScene().fetchAltitude() > minimumElevation {
            let distanceIntoRange = getScene().fetchAltitude() - minimumElevation
            var transitionPercentage = distanceIntoRange / config.transitionDistance
            var invertedTransitionPercentage = abs(1 - transitionPercentage)
            transitionPercentage = clamp(value: transitionPercentage, min: 0, max: 1)
            invertedTransitionPercentage = clamp(value: invertedTransitionPercentage, min: 0, max: 1)
            ambiencePlayer?.volume = config.ambienceVolume * Float(invertedTransitionPercentage)
            ambiencePlayer2?.volume = config.ambienceVolume * Float(transitionPercentage)
        }
        return
    }
}
