//
//  SettingsView.swift
//  HoppsTestScene
//
//  Created by Rayaan Ismail on 5/21/25.
//

import SwiftUI

struct SettingsView: View {
    @Bindable var vm: NavigationHubViewModel
    var body: some View {
        ZStack {
            // Background, bottom layer
            BlurredBackground()
            
            GeometryReader { geo in
                // Back arrow
                VStack {
                    HStack {
                        Button {
                            vm.currentView = .mainMenu
                        } label: {
                            Image(.arrowIcon)
                                .scaleEffect(vm.topBarIconScale)
                        }
                        Spacer()
                    }
                    VStack {
                        Text("Settings")
                            .font(.custom("Silom", size: 30))
                            .foregroundStyle(.customWoodBrown)
                            .padding(10)
                            .background {
                                Image(.woodButton35)
                            }
                            .offset(y: -30)
                        
                        HStack {
                            VStack {
                                Text("Controls")
                            }
                            
                            VStack {
                                Text("Vibration")
                            }
                        }
                        
                        VStack {
                            Text("SFX")
                        }
                    }
                    
                    
                }
                .frame(maxHeight: .infinity, alignment: .top)
            }
            /// End of Screen Contents
        }
    }
}

#Preview {
    SettingsView(vm: NavigationHubViewModel())
}
