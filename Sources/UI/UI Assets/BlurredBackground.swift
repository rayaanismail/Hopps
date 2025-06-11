//  BlurredBackground.swift
//  HoppsTestScene
//
//  Created by Rayaan Ismail on 5/21/25.
//

import SwiftUI

/// A blurred image of the default game background with the Hopps title overlaid
struct BlurredBackground: View {
    var body: some View {
        ZStack(alignment: .top) {
            Image(.uiBackground)
                .resizable()
                .ignoresSafeArea()
                .scaledToFill()
                .blur(radius: 5, opaque: true)

            // Hopps title at the top center
           
        }
    }
}

#Preview {
    BlurredBackground()
}
