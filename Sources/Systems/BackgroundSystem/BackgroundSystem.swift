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
        return SKColor(red: 87/255, green: 229/255, blue: 244/255, alpha: 1.0)
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
    
    private var cloudLayers: [SKSpriteNode] = []
    private let cloudStageLayer: SKSpriteNode
    
    private var testNode = SKSpriteNode(color: .red, size: CGSize(width: 50, height: 50))
    
    
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
        layer1.zPosition = config.layerZPositions[0]
        layer1.setScale(backgroundScale)
        layer1.position = CGPoint(x: config.size.width / 2, y: config.size.height / 2)
        layers.append(layer1)
        
        
        
        layer2 = SKSpriteNode(imageNamed: "Layer2")
        layer2.anchorPoint = CGPoint(x: 1, y: 0.6)
        layer2.zPosition = config.layerZPositions[1]
        layer2.setScale(backgroundScale)
        layer2.position = CGPoint(x: config.size.width / 2, y: config.size.height / 2)
        layers.append(layer2)
        
        layer3 = SKSpriteNode(imageNamed: "Layer3")
        layer3.anchorPoint = CGPoint(x: 1, y: 0.6)
        layer3.zPosition = config.layerZPositions[2]
        layer3.setScale(backgroundScale)
        layer3.position = CGPoint(x: config.size.width / 2, y: config.size.height / 2)
        layers.append(layer3)
        
        // Cloud Stage Layer
        cloudStageLayer = SKSpriteNode(texture: SKTexture(image: .cloudStageBackground))
        cloudStageLayer.anchorPoint = CGPoint(x: 0.5, y: 0)
        cloudStageLayer.position = CGPoint(x: 0, y: config.cloudLayerLowerBound)
        cloudStageLayer.zPosition = config.layerZPositions[0] - 10
        cloudStageLayer.setScale(backgroundScale)
        
        
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
        
        cloudLayers = createClouds(config: config)
        
        
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
        cloudLayers.forEach {
            addChild($0)
            $0.run(SKAction.moveBy(x: -config.size.width * 1.3, y: 0, duration: 100))}
        addChild(gradientFade)
        addChild(spaceOverlay)
        addChild(altitudeLabel)
        addChild(stars)
        addChild(cloudStageLayer)
        
        
        // Test Node
//        addChild(testNode)
//        testNode.position = localizedCoordinates(origin: getScene().fetchCameraPosition(), view:  getScene().fetchView(), desiredPosition: CGPoint(x: 1, y: 0.5))
        
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
        /// Scrolls Background layers according to scroll speeds
        layers.indices.forEach { i in
            layers[i].position.y = -(getCameraPosition().y * config.scrollSpeeds[i])
        }
        
        /// Scrolls Cloud layers according to their scroll speeds
        cloudLayers.enumerated().forEach { idx, cloud in
            cloud.position.y = -(getCameraPosition().y  * config.cloudYSpeeds[idx]) + config.cloudPositions[idx].y
        }
        cloudStageLayer.position.y = layer1.position.y + 450
    }
    
    func followCamera() {
        self.position = (scene as? GameScene)?.cameraSystem?.cameraNode.position ?? CGPoint.zero
    }
}
