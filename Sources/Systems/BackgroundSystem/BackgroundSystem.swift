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
        return SKColor(red: 87/255, green: 200/255, blue: 255/255, alpha: 1.0)
    }
}

class BackgroundSystem: SKNode, GameSystem {
    // Properties
    private let config: BackgroundConfig
    private let baseSky: SKSpriteNode
    let gradientFade: SKSpriteNode
    private let landBackground: SKSpriteNode
    
    let spaceOverlay: SKSpriteNode
    let fadeStart: CGFloat
    let fadeEnd: CGFloat
    
    let altitudeLabel: SKLabelNode
    let stars: SKEmitterNode
    var topY: CGFloat {
        spaceOverlay.position.y * 2
    }
    
    
    // Init
    init(config: BackgroundConfig) {
        self.config = config
        
        // Initializes base sky & space background
        // Solid Blue Base Background
        baseSky = SKSpriteNode(color: .skyBlue, size: config.size)
        baseSky.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        baseSky.zPosition = -100 /// A lesser z position is more 'out' of the screen, so blue would be in the background
        baseSky.setScale(1.25)
        
        // Simulated white to transparent fade overlay
        gradientFade = SKSpriteNode(color: .clear, size: config.size)
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
        
        // Land Background Initialization
        landBackground = SKSpriteNode(imageNamed: "LandBackground")
        landBackground.anchorPoint = CGPoint(x: 1, y: 0.18)
        landBackground.zPosition = -60
        let backgroundScale = config.size.width / (landBackground.size.width - 3)
        landBackground.setScale(backgroundScale)
        landBackground.position = CGPoint(x: config.size.width / 2, y: config.size.height / 2)
        
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
        addChild(landBackground)
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
        scrollBackground()
        followCamera()
    }
    func scrollBackground() {
        landBackground.position.y = -(getCameraPosition().y * config.scrollSpeed)
    }
    
    func followCamera() {
        self.position = (scene as? GameScene)?.cameraSystem?.cameraNode.position ?? CGPoint.zero
    }
}
