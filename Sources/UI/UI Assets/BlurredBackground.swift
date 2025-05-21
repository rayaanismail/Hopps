//
//  BlurredBackground.swift
//  HoppsTestScene
//
//  Created by Rayaan Ismail on 5/21/25.
//

import SwiftUI

/// A blurred image of the default game background
struct BlurredBackground: View {
    var body: some View {
        Image(.uiBackground)
            .resizable()
            .ignoresSafeArea()
            .scaledToFill()
            .blur(radius: 5, opaque: true)
    }
}

#Preview {
    BlurredBackground()
}
