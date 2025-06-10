
//  Hopps
//
//  Created by Rayaan Ismail on 6/6/25.
//

import Foundation
import SpriteKit

extension GameScene {
    func prepareDeinit() {
        soundSystem?.deallocatePersistentAudio()
        systems.forEach { system in
            let node = system as! SKNode
            node.removeAllActions()
            node.removeAllChildren()
            node.removeFromParent()
        }
        
        
    }
    
    
}
