//
//  GameTime.swift
//  HoppsTestScene
//
//  Created by Rayaan Ismail on 5/7/25.
//

import Foundation
import SpriteKit


/// Stores and calculates time data relative to a scene restart
struct GameTime {
    
    private var initialized: Bool = false
    /// Stores the current time interval from the GameScene's update loop, the struct will treat this as the 'zero' or start time.
    var sceneStartTime: TimeInterval = 0
    
    /// Stores the the time elapsed between the last and current update loop (framerate).
    var deltaTime: TimeInterval = 0
    
    /// Stores the last time the struct was updated
    var lastTime: TimeInterval = 0
    
    /// Total time elapsed from the scene start time.
    var elapsedTime: TimeInterval = 0
    
    /// The current framerate of the game scene
    var fps: Double {
        1.0 / deltaTime
    }
    
    /// Initializes and updates the scenes time data based on the current time interval.
    mutating func update(currentTime: TimeInterval) {
        if !initialized {
            reset(currentTime: currentTime)
            return
        }
        
        deltaTime = currentTime - lastTime
        lastTime = currentTime
        elapsedTime = currentTime - sceneStartTime
    }
    
    /// Prints debug time data: Start time, elapsed time, last time, deltatime
    func printTimeData() {
        print("""
            Scene Time Initialized at: \(sceneStartTime.rounded())
            Total Elapsed Time: \(elapsedTime.rounded())
            Last Time Updated: \(lastTime)
            Delta Time from Last: \(deltaTime)
            
            FPS: \(fps.rounded())
            """)
    }
    
    mutating func reset(currentTime: TimeInterval) {
        sceneStartTime = currentTime
        lastTime = currentTime
        initialized = true
        deltaTime = 0
        elapsedTime = 0
    }
}

