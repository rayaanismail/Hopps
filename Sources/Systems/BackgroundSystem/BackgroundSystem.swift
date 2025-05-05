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
    private let layer1: SKSpriteNode
    private let layer2: SKSpriteNode
    private let layer3: SKSpriteNode
    private var layers: [SKSpriteNode] = []
    
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
        
        // Background Parallax Layer Initialization
        layer1 = SKSpriteNode(imageNamed: "Layer1")
        let backgroundScale = config.size.width / (layer1.size.width - 3)
        layer1.anchorPoint = CGPoint(x: 1, y: 0.5)
        layer1.zPosition = -60
        layer1.setScale(backgroundScale)
        layer1.position = CGPoint(x: config.size.width / 2, y: config.size.height / 2)
        layers.append(layer1)
        
        layer2 = SKSpriteNode(imageNamed: "Layer2")
        layer2.anchorPoint = CGPoint(x: 1, y: 0.6)
        layer2.zPosition = -59
        layer2.setScale(backgroundScale)
        layer2.position = CGPoint(x: config.size.width / 2, y: config.size.height / 2)
        layers.append(layer2)
        
        layer3 = SKSpriteNode(imageNamed: "Layer3")
        layer3.anchorPoint = CGPoint(x: 1, y: 0.6)
        layer3.zPosition = -55
        layer3.setScale(backgroundScale)
        layer3.position = CGPoint(x: config.size.width / 2, y: config.size.height / 2)
        layers.append(layer3)
        
        
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
        layers.forEach {addChild($0)}
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
    
    /// Scrolls the parallax layers according to their scrollspeed
    func scrollBackground() {
        layers.indices.forEach { i in
            layers[i].position.y = -(getCameraPosition().y * config.scrollSpeeds[i])
        }
    }
    
    func followCamera() {
        self.position = (scene as? GameScene)?.cameraSystem?.cameraNode.position ?? CGPoint.zero
    }
}
