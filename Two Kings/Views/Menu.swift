//
//  Menu.swift
//  Two Kings
//
//  Created by Алкександр Степанов on 13.08.2025.
//

import SwiftUI

struct Menu: View {
    @AppStorage("coinCount") var coinCount = 0
    @AppStorage("sound") var sound = false
    @AppStorage("languageIndex") var languageIndex = 0
    @AppStorage("firstStart") var firstStart = true
    @State private var showDailyReward = false
    @State private var showSettings = false
    @State private var showCollection = false
    @State private var showShop = false
    @State private var showAchievements = false
    @State private var showChoseLevel = false
    @State private var showTask = false
    @State private var objectsOpacity: CGFloat = 1
    @State private var languageMenuArray = Arrays.languageMenuArray
    var body: some View {
        GeometryReader { geometry in
            let height = geometry.size.height
            let width = geometry.size.width
            let isLandscape = width > height
            if isLandscape {
                ZStack {
                    Backgrouns(backgroundNumber: 0)
                    Image(.icon2)
                        .resizable()
                        .scaledToFit()
                        .frame(width: width*0.13)
                        .frame(maxHeight: .infinity, alignment: .top)
                        .padding(.top)
                        .opacity(objectsOpacity)
                    HStack(alignment: .top) {
                        Image(.butterflyCollectionsButton)
                            .resizable()
                            .scaledToFit()
                            .frame(width: width*0.135)
                            .onTapGesture {
                                showCollection.toggle()
                            }
                            .opacity(objectsOpacity)
                        Spacer()
                        Image(.coinFrame)
                            .resizable()
                            .scaledToFit()
                            .frame(width: width*0.2)
                            .overlay(
                                Text("\(coinCount)")
                                    .font(Font.custom("PaytoneOne-Regular", size: width*0.03))
                                    .foregroundColor(.white)
                                    .shadow(color: .black, radius: 2)
                                    .shadow(color: .black, radius: 2)
                                    .offset(x: width*0.02)
                            )
                    }
                    .frame(maxHeight: .infinity, alignment: .top)
                    .padding(.top)
                    .padding(.horizontal)
                    Image(.settingsButton)
                        .resizable()
                        .scaledToFit()
                        .frame(width: width*0.08)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomLeading)
                        .padding()
                        .opacity(objectsOpacity)
                        .onTapGesture {
                            showSettings.toggle()
                        }
                    VStack(spacing: width*0.02) {
                        HStack(spacing: width*0.12) {
                            Buttons(size: 0.3, text: languageMenuArray[languageIndex][0], textSize: 1)
                                .onTapGesture {
                                    showChoseLevel.toggle()
                                }
                            Buttons(size: 0.3, text: languageMenuArray[languageIndex][1], textSize: 1)
                                .onTapGesture {
                                    showAchievements.toggle()
                                }
                        }
                        HStack(spacing: width*0.02) {
                            Buttons(size: 0.3, text: languageMenuArray[languageIndex][2], textSize: 1)
                                .onTapGesture {
                                    showTask.toggle()
                                }
                            Buttons(size: 0.3, text: languageMenuArray[languageIndex][3], textSize: 1)
                                .onTapGesture {
                                    showShop.toggle()
                                }
                        }
                    }
                    .offset(y: width*0.05)
                    .opacity(objectsOpacity)
                    
                    if showDailyReward {
                        DaylyReward(showDailyReward: $showDailyReward)
                    }
                    if showSettings {
                        Settings(showSettings: $showSettings)
                    }
                    if showCollection {
                        ChoseCollection(showCollection: $showCollection)
                    }
                    if showShop {
                        Shop(showShop: $showShop)
                    }
                    if showAchievements {
                        Achievements(showAchievements: $showAchievements)
                    }
                    if showChoseLevel {
                        ChoseLevel(showChoseLevel: $showChoseLevel)
                    }
                    if showTask {
                        DailyTask(showTask: $showTask)
                    }
                    
                }
                .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
            } else {
                
            }
        }
        
        .onAppear {
            if sound {
                SoundManager.instance.stopAllSounds()
                SoundManager.instance.playSound(sound: "music")
            }
            if firstStart {
                showDailyReward = true
            }
        }
        
        .onChange(of: showTask) { _ in
            if showTask {
                showSubView()
            } else {
                hideSubView()
                firstStart = false
            }
        }
        .onChange(of: showDailyReward) { _ in
            if showDailyReward {
                showSubView()
            } else {
                hideSubView()
                firstStart = false
            }
        }
        .onChange(of: showSettings) { _ in
            if showSettings {
                showSubView()
            } else {
                hideSubView()
            }
        }
        .onChange(of: showCollection) { _ in
            if showCollection {
                showSubView()
            } else {
                hideSubView()
            }
        }
        .onChange(of: showShop) { _ in
            if showShop {
                showSubView()
            } else {
                hideSubView()
                firstStart = false
            }
        }
        .onChange(of: showAchievements) { _ in
            if showAchievements {
                showSubView()
            } else {
                hideSubView()
                firstStart = false
            }
        }
        .onChange(of: showChoseLevel) { _ in
            if showChoseLevel {
                showSubView()
            } else {
                hideSubView()
                firstStart = false
            }
        }
        
    }
    
    func showSubView() {
        withAnimation(Animation.easeInOut(duration: 0.3)) {
            objectsOpacity = 0
        }
    }
    
    func hideSubView() {
        withAnimation(Animation.easeInOut(duration: 0.3)) {
            objectsOpacity = 1
        }
    }
    
}

#Preview {
    Menu()
}
