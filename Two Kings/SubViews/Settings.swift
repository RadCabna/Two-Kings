//
//  Settings.swift
//  Two Kings
//
//  Created by Алкександр Степанов on 14.08.2025.
//

import SwiftUI

struct Settings: View {
    @AppStorage("coinCount") var coinCount = 0
    @AppStorage("languageIndex") var languageIndex = 0
    @AppStorage("sound") var sound = false
    @State private var flagArray = Arrays.flagArrays
    @State private var languageSettingsArray = Arrays.languageSettingsArray
    @State private var flagOffset: CGFloat = 0
    @Binding var showSettings: Bool
    var body: some View {
        ZStack {
            HStack(alignment: .top) {
                Image(.buttonBack)
                    .resizable()
                    .scaledToFit()
                    .frame(width: screenWidth*0.07)
                    .onTapGesture {
                        showSettings.toggle()
                    }
                Spacer()
                Image(.coinFrame)
                    .resizable()
                    .scaledToFit()
                    .frame(width: screenWidth*0.2)
                    .overlay(
                        Text("\(coinCount)")
                            .font(Font.custom("PaytoneOne-Regular", size: screenWidth*0.03))
                            .foregroundColor(.white)
                            .shadow(color: .black, radius: 2)
                            .shadow(color: .black, radius: 2)
                            .offset(x: screenWidth*0.02)
                    )
            }
            .frame(maxHeight: .infinity, alignment: .top)
            .frame(maxWidth: screenWidth*0.95)
            .padding(.horizontal)
            .padding(.top)
            VStack {
                Image(.rewardHeadFrame)
                    .resizable()
                    .scaledToFit()
                    .frame(width: screenWidth*0.3)
                    .overlay(
                        Text(languageSettingsArray[languageIndex][0])
                            .font(Font.custom("PaytoneOne-Regular", size: screenWidth*0.03))
                            .foregroundColor(.white)
                            .shadow(color: .black, radius: 2)
                            .shadow(color: .black, radius: 2)
                            .textCase(.uppercase)
                            .offset(y: -screenWidth*0.002)
                    )
                Image(.settingsFrame)
                    .resizable()
                    .scaledToFit()
                    .frame(width: screenWidth*0.35)
                    .overlay(
                        VStack {
                            HStack {
                                Text(sound ? languageSettingsArray[languageIndex][1] : languageSettingsArray[languageIndex][2])
                                    .font(Font.custom("PaytoneOne-Regular", size: screenWidth*0.03))
                                    .foregroundColor(.white)
                                    .shadow(color: .black, radius: 2)
                                    .shadow(color: .black, radius: 2)
                                Spacer()
                                Image(sound ? .soundOn : .soundOff)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: screenWidth*0.07)
                                    .onTapGesture {
                                        sound.toggle()
                                    }
                            }
                            .frame(maxWidth: screenWidth*0.29)
                            Spacer()
                            HStack {
                                Text(languageSettingsArray[languageIndex][3])
                                    .font(Font.custom("PaytoneOne-Regular", size: screenWidth*0.03))
                                    .foregroundColor(.white)
                                    .shadow(color: .black, radius: 2)
                                    .shadow(color: .black, radius: 2)
                                Spacer()
                                VStack {
                                    Image(.arrowUp)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: screenWidth*0.03)
                                        .onTapGesture {
                                            changeLanguage(direction: -1)
                                        }
                                    Image(.languageFrame)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: screenWidth*0.07)
                                        .overlay(
                                            Image(flagArray[languageIndex])
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: screenWidth*0.06)
                                                .offset(y: flagOffset)
                                                .mask(
                                                    Image(flagArray[languageIndex])
                                                        .resizable()
                                                        .scaledToFit()
                                                        .frame(width: screenWidth*0.06)
                                                )
                                        )
                                    Image(.arrowUp)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: screenWidth*0.03)
                                        .scaleEffect(y: -1)
                                        .onTapGesture {
                                            changeLanguage(direction: 1)
                                        }
                                }
                            }
                            .frame(maxWidth: screenWidth*0.29)
                        }
                            .frame(maxHeight: screenWidth*0.27)
                    )
            }
            .offset(y: screenWidth*0.02)
        }
        .onChange(of: sound) { _ in
            if sound {
                SoundManager.instance.stopAllSounds()
                SoundManager.instance.playSound(sound: "music")
            } else {
                SoundManager.instance.stopAllSounds()
            }
            
        }
    }
    
    func changeLanguage(direction: Double) {
        withAnimation(Animation.easeInOut(duration: 0.3)) {
            flagOffset = direction*screenWidth*0.1
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            languageIndex += Int(direction)
            if languageIndex < 0 {
                languageIndex = 3
            }
            if languageIndex == 4 {
                languageIndex = 0
            }
            flagOffset = -direction*screenWidth*0.1
            withAnimation(Animation.easeInOut(duration: 0.3)) {
                flagOffset = 0
            }
        }
    }
    
}

#Preview {
    Settings(showSettings: .constant(true))
}
