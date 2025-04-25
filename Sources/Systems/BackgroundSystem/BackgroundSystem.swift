//
//  BackgroundSystem.swift
//  HoppsTestScene
//
//  Created by Rayaan Ismail on 4/19/25.
//

import Foundation
import SpriteKit

// MARK: – 1. Configuration
// ⮕ Keeps “magic numbers” and tuning parameters out of code.
// ⮕ Allows designers to tweak gradients & parallax without touching logic.


extension SKColor {
    static var skyBlue: SKColor {
        return SKColor(red: 0.25, green: 0.7, blue: 1.0, alpha: 1.0)
    }
}

class BackgroundSystem: SKNode, GameSystem {
    // Properties
    
    private let config: BackgroundConfig
    private let baseSky: SKSpriteNode
    private let gradientFade: SKSpriteNode
    
    private let spaceOverlay: SKSpriteNode
    private let fadeStart: CGFloat
    private let fadeEnd: CGFloat
    
    private let altitudeLabel: SKLabelNode
    private let stars: SKEmitterNode
    var topY: CGFloat {
        spaceOverlay.position.y * 2
    }
    
    
    // Init
    init(config: BackgroundConfig) {
        self.config = config
        
        // Initializes base sky & space background
        // Solid Blue Base Background
        baseSky = SKSpriteNode(imageNamed: "PixelSky")
        baseSky.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        baseSky.zPosition = -100 /// A lesser z position is more 'out' of the screen, so blue would be in the background
        baseSky.setScale(1.25)
        
        // Simulated white to transparent fade overlay
        gradientFade = SKSpriteNode(color: .white, size: config.size)
        gradientFade.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        gradientFade.alpha = 0.4
        gradientFade.blendMode = .alpha
        gradientFade.zPosition = -90
        
        // Black overlay to simulate space "fade in"
        spaceOverlay = SKSpriteNode(imageNamed: "PixelStars")
        spaceOverlay.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        spaceOverlay.alpha = 0.0
        spaceOverlay.blendMode = .alpha
        spaceOverlay.zPosition = -80
        
        
        // Simple Label debug
        altitudeLabel = SKLabelNode(text: "0")
        altitudeLabel.position = CGPoint(x: config.size.width * 0.8, y: config.size.height * 0.95)
        altitudeLabel.zPosition = -70
        altitudeLabel.fontColor = .white
        altitudeLabel.blendMode = .add
        
        // Star particle Emitter
        stars = SKEmitterNode(fileNamed: "Stars.sks")!
        stars.zPosition = -75
        stars.alpha = 0
        stars.position = CGPoint(x: config.size.width / 2, y: config.size.height / 2)
        stars.particlePositionRange = CGVector(dx: config.size.width, dy: config.size.height)
        stars.particleBirthRate = 5
        stars.particleLifetime = 10
        stars.particleSize = CGSize(width: config.particleSize, height: config.particleSize)
        
        fadeStart = config.fadeStart
        fadeEnd = config.fadeEnd
        
        // Initializes the class as a blank node
        super.init()
        
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Setup(in: )
    // Called once by Gamescene.didMove(to: )
    // Add nodes to scene NO LOGIC HERE
    func setup(in scene: SKScene) {
        scene.addChild(self) // Adds itself to the gamescene
        addChild(baseSky)
        addChild(gradientFade)
        addChild(spaceOverlay)
        addChild(altitudeLabel)
        addChild(stars)
        
        // BUILD PARALLAX LOGIC
        // MARK: TODO
    }
    
    // MARK: Update(deltaTime: )
    // Pure per frame logic. No node creation here
    func update(deltaTime: TimeInterval) {
        elevationTransition()
        self.position = (scene as? GameScene)?.cameraSystem?.cameraNode.position ?? CGPoint.zero
    }
    
    func elevationTransition() {
        let altitude: CGFloat = (scene as? GameScene)?.cameraSystem?.cameraNode.position.y ?? 0
        let maxOpacity: CGFloat = 0.85
        // Fade to space based on altitude
        
        // Normalize altitude into a range [0, 1] for blending
        var t: CGFloat
        if altitude <= fadeStart {
            t = 0.0
        } else if altitude >= fadeEnd {
            t = maxOpacity
        } else {
            t = (altitude - fadeStart) / (fadeEnd - fadeStart)
            t = clamp(value: t, min: 0, max: maxOpacity)
        }
        
        // --- Layer Adjustments ---
        // Fade in the black "space" overlay gradually
        spaceOverlay.alpha = t
        
        // Fade out the soft white gradient as we rise into space
        let maxGradientAlpha: CGFloat = 0.9
        gradientFade.alpha = (1.0 - t) * maxGradientAlpha
        
        spaceOverlay.alpha = t
        stars.alpha = t
        
        // Optional: reduce gradient as space takes over
        gradientFade.alpha = (1 - t) * 0.5 // Lower this to make sky bluer sooner
        
        altitudeLabel.text = "\(altitude)"
        
    }
}
