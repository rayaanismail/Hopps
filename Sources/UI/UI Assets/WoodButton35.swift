//
//  WoodButton35.swift
//  HoppsTestScene
//
//  Created by Rayaan Ismail on 5/21/25.
//

import SwiftUI

struct WoodButton35: View {
    var text: String
    var fontSize: CGFloat = 30
    var body: some View {
        ZStack {
            Image(.woodButton35)
            
            Text(text)
                .font(.custom("Silom", size: fontSize))
                .foregroundStyle(.customWoodBrown)
        }
    }
}

#Preview {
    WoodButton35(text: "Start")
}
