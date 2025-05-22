//
//  ImageToggleLabel.swift
//  HoppsTestScene
//
//  Created by Rayaan Ismail on 5/21/25.
//

import SwiftUI

/// Given two image names, the view will dynamically switch between the two states based on a boolean binidnig
struct ImageToggleLabel: View {
    var onState: String = "TiltIcon"
    var offState: String = "TouchIcon"
    var toggle: Binding<Bool>
    
    var body: some View {
        ZStack {
            Image(onState)
                .opacity(toggle.wrappedValue ? 1 : 0)
            
            Image(offState)
                .opacity(!toggle.wrappedValue ? 1 : 0)
                
        }
    }
}

#Preview {
    @Previewable @State var toggled = true
    
    ZStack {
        VStack {
            ImageToggleLabel(toggle: $toggled)
                .font(.custom("", size: 60))
                .foregroundStyle(.white)
            Button("Toggle") {
                toggled.toggle()
            }
            .buttonStyle(.bordered)
        }
    }
    .ignoresSafeArea()
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(toggled ? .yellow.mix(with: .gray, by: 0.8) : .black)
    
    
}
