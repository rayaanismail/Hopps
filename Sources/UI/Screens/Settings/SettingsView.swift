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
                            // Save settings then switch to main menu
                            vm.currentView = .mainMenu
                            
                        } label: {
                            Image(.arrowIcon)
                                .scaleEffect(0.6)
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
                    }
                    
                    VStack {
                        HStack (alignment: .top){
                            VStack {
                                Text("Controls")
                                    .font(.custom("Silom", size: 24))
                                    .foregroundStyle(.customWoodBrown)
                                    .padding(.horizontal, 10)
                                    .background(.white.opacity(0.4))
                                    .clipShape(RoundedRectangle(cornerRadius: 6))
                                
                                Button {
                                    vm.touchEnabled.toggle()
                                    vm.saveSettings()
                                } label: {
                                    VStack {
                                        ImageToggleLabel(onState: "TouchIcon", offState: "TiltIcon", toggle: $vm.touchEnabled)
                                            .scaleEffect(2)
                                            .padding(.top, 20)
                                        Text(vm.touchEnabled ? "Touch" : "Tilt")
                                            .padding(5)
                                            .background(.white.opacity(0.4))
                                            .foregroundStyle(vm.touchEnabled ? .customWoodBrown : .customWoodBrown)
                                            .bold()
                                            .clipShape(RoundedRectangle(cornerRadius: 6))
                                            .padding(.top, 20)
                                    }
                                }
                            }
                            .padding(.horizontal)
                            .frame(maxWidth: 190)
                            
                            VStack {
                                Text("Vibration")
                                    .font(.custom("Silom", size: 24))
                                    .foregroundStyle(.customWoodBrown)
                                    .padding(.horizontal, 10)
                                    .background(.white.opacity(0.4))
                                    .clipShape(RoundedRectangle(cornerRadius: 6))
                                
                                Button {
                                    vm.vibrationEnabled.toggle()
                                    vm.saveSettings()
                                } label: {
                                    VStack {
                                        ImageToggleLabel(onState: "VibrationEnabledIcon", offState: "VibrationDisabledIcon", toggle: $vm.vibrationEnabled)
                                            .scaleEffect(2)
                                            .padding(.top, 20)
                                        Text(vm.vibrationEnabled ? "Vibration On" : "Vibration Off")
                                            .padding(5)
                                            .background(.white.opacity(0.4))
                                            .foregroundStyle(.customWoodBrown)
                                            .bold()
                                            .clipShape(RoundedRectangle(cornerRadius: 6))
                                            .padding(.top, 20)
                                            
                                    }
                                }
                            }
                            .padding(.horizontal)
                            .frame(maxWidth: 190)
                        }
                        
                        Button {
                            vm.sfxEnabled.toggle()
                            vm.saveSettings()
                        } label: {
                            VStack {
                                Text("SFX")
                                    .font(.custom("Silom", size: 24))
                                    .foregroundStyle(.customWoodBrown)
                                    .padding(.horizontal, 10)
                                    .background(.white.opacity(0.4))
                                    .clipShape(RoundedRectangle(cornerRadius: 6))
                                
                                ImageToggleLabel(onState:
                                                    "SoundOn",
                                                 offState:
                                                    "SoundOff",
                                                 toggle:
                                                    $vm.sfxEnabled)
                                .scaleEffect(4)
                                Text(vm.sfxEnabled ?
                                     "Sound On" : "Sound Off")
                                .padding(5)
                                .background(.white.opacity(0.4))
                                .foregroundStyle(.customWoodBrown)
                                .bold()
                                .clipShape(RoundedRectangle(cornerRadius: 6))
                                
                            }
                            
                        }
                        }
                        .padding(.top, 20)
                    }
                    .padding(.top, geo.size.height * 0.05)
                    
                    
                }
                .padding(.top, 20)
                .frame(maxHeight: .infinity, alignment: .top)
            }
            /// End of Screen Contents
        }
    }


#Preview {
    SettingsView(vm: NavigationHubViewModel())
}
