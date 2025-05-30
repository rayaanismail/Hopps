//
//  BackgroundHandler.swift
//  HoppsTestScene
//
//  Created by Rayaan Ismail on 4/17/25.
//

import Foundation
import SpriteKit

class BackgroundScene: SKScene {
    var altitude: CGFloat = 0 /// Represents Player Height
    let debugAltitude: CGFloat = 1000
    
    var backgroundHandler: BackgroundHandler?
    var starParticles: SKEmitterNode?
    
    var sceneSize: CGSize = .zero
    
    
    override func didMove(to view: SKView)
    {
        sceneSize = view.frame.size
        backgroundHandler = BackgroundHandler(size: view.frame.size )
        setupStars()
        addChild(backgroundHandler!)
        altitude = debugAltitude
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        altitude = debugAltitude
        starParticles?.alpha = 0
    }
    
    override func update(_ currentTime: TimeInterval) {
        altitude += 1
        starParticles!.alpha = (backgroundHandler?.update(forAltitude: altitude))!
        updateStars()
    }
    
    private func setupStars() {
        guard let stars = SKEmitterNode(fileNamed: "Stars.sks") else { return }

        stars.zPosition = -75
        stars.alpha = 0
        stars.position = CGPoint(x: sceneSize.width / 2, y: sceneSize.height / 2)
        stars.particlePositionRange = CGVector(dx: sceneSize.width, dy: sceneSize.height)
        stars.particleBirthRate = 7
        stars.particleLifetime = 10
        stars.particleSize = CGSize(width: 3, height: 3)
       
        self.starParticles = stars
        addChild(stars)
    }
    
    private func updateStars() {
        if altitude > 3000 {
            starParticles?.alpha = 1
        }
    }
}



class BackgroundHandler: SKNode {
    private let baseSky: SKSpriteNode
    private let gradientFade: SKSpriteNode
    private let spaceOverlay: SKSpriteNode
    private let altitudeLabel: SKLabelNode
    
    init(size: CGSize) {
        // Solid Blue Base Background
        baseSky = SKSpriteNode(imageNamed: "PixelSky")
        baseSky.anchorPoint = .zero
        baseSky.zPosition = -100 /// A lesser z position is more 'out' of the screen, so blue would be in the background
        baseSky.setScale(1.25)
        // Simulated white to transparent fade overlay
        gradientFade = SKSpriteNode(color: .white, size: size)
        gradientFade.anchorPoint = .zero
        gradientFade.alpha = 0.4
        gradientFade.blendMode = .alpha
        gradientFade.zPosition = -90
        
        // Black overlay to simulate space "fade in"
        spaceOverlay = SKSpriteNode(imageNamed: "PixelStars")
        spaceOverlay.anchorPoint = .zero
        spaceOverlay.alpha = 0.0
        spaceOverlay.blendMode = .alpha
        spaceOverlay.zPosition = -80
        
        // Simple Label debug
        altitudeLabel = SKLabelNode(text: "0")
        altitudeLabel.position = CGPoint(x: size.width * 0.8, y: size.height * 0.95)
        altitudeLabel.zPosition = -70
        altitudeLabel.fontColor = .white
        altitudeLabel.blendMode = .add
        
        // Initializes the class as a blank node
        super.init()
        
        addChild(baseSky)
        addChild(gradientFade)
        addChild(spaceOverlay)
        addChild(altitudeLabel)
    }
    required init?(coder aDecoder: NSCoder) { fatalError() }
    
    func update(forAltitude altitude: CGFloat) -> CGFloat {
        // Fade to space based on altitude
        let fadeStart: CGFloat = 1000 // Where space starts to fade in
        let fadeEnd: CGFloat = 3000  // Where space is fully visible
        
        // Normalize altitude into a range [0, 1] for blending
        let t: CGFloat
        if altitude <= fadeStart {
            t = 0.0
        } else if altitude >= fadeEnd {
            t = 1.0
        } else {
            t = (altitude - fadeStart) / (fadeEnd - fadeStart)
        }
        
        // --- Layer Adjustments ---
        // Fade in the black "space" overlay gradually
        spaceOverlay.alpha = t
        
        // Fade out the soft white gradient as we rise into space
        let maxGradientAlpha: CGFloat = 0.9
        gradientFade.alpha = (1.0 - t) * maxGradientAlpha
        
        spaceOverlay.alpha = t
        
        // Optional: reduce gradient as space takes over
        gradientFade.alpha = (1 - t) * 0.5 // Lower this to make sky bluer sooner
        
        altitudeLabel.text = "\(altitude)"
        return spaceOverlay.alpha
    }
}
