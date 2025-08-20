//
//  Achievements.swift
//  Two Kings
//
//  Created by Алкександр Степанов on 15.08.2025.
//

import SwiftUI

struct Achievements: View {
    @AppStorage("coinCount") var coinCount = 0
    @AppStorage("languageIndex") var languageIndex = 0
    @State private var achievementsArray = Arrays.achievementsArray
    @State private var achievementsData = UserDefaults.standard.array(forKey: "achievementsData") as? [Int] ?? [0,0,0,0,0]
    @State private var achievementsTextArray = ["Achievements", "Obiettivi", "Erfolge", "Logros"]
    @Binding var showAchievements: Bool
    var body: some View {
        ZStack {
            HStack(alignment: .top) {
                Image(.buttonBack)
                    .resizable()
                    .scaledToFit()
                    .frame(width: screenWidth*0.07)
                    .onTapGesture {
                        showAchievements.toggle()
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
                        Text(achievementsTextArray[languageIndex])
                            .font(Font.custom("PaytoneOne-Regular", size: screenWidth*0.03))
                            .foregroundColor(.white)
                            .shadow(color: .black, radius: 2)
                            .shadow(color: .black, radius: 2)
                            .textCase(.uppercase)
                            .offset(y: -screenWidth*0.002)
                    )
                Image(.unqueFrame)
                    .resizable()
                    .scaledToFit()
                    .frame(width: screenWidth*0.8)
                    .overlay(
                        HStack(alignment: .top) {
                            ForEach(0..<achievementsData.count, id: \.self) { item in
                                VStack {
                                    Text(achievementsArray[item].name)
                                        .font(Font.custom("PaytoneOne-Regular", size: screenWidth*0.015))
                                        .foregroundColor(.white)
                                        .shadow(color: .black, radius: 2)
                                    ZStack {
                                        Image(.dayFrame)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: screenWidth*0.09)
                                        Image(achievementsData[item] == 0 ? achievementsArray[item].imageOff : achievementsArray[item].imageOn)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: screenWidth*0.08)
                                            .mask(
                                                Image(.dayFrame)
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(width: screenWidth*0.08)
                                            )
                                            .overlay(
                                                ZStack {
                                                    if achievementsData[item] == 1 {
                                                        Image(.getButton)
                                                            .resizable()
                                                            .scaledToFit()
                                                            .frame(width: screenWidth*0.09)
                                                            .onTapGesture {
                                                                achievementsData[item] = 2
                                                                UserDefaults.standard.set(achievementsData, forKey: "achievementsData")
                                                                coinCount += 10
                                                            }
                                                        Image(.lockButton)
                                                            .resizable()
                                                            .scaledToFit()
                                                            .frame(width: screenWidth*0.03)
                                                            .offset(x: screenWidth*0.035, y: screenWidth*0.035)
                                                    }
                                                }
                                            )
                                    }
                                    Text(achievementsArray[item].text)
                                        .font(Font.custom("PaytoneOne-Regular", size: screenWidth*0.015))
                                        .foregroundColor(.white)
                                        .shadow(color: .black, radius: 2)
                                        .multilineTextAlignment(.center)
                                }
                                
                                .frame(minWidth: screenWidth*0.14)
                                .offset(y:achievementsArray[item].offset*screenWidth)
                            }
                        }
                    )
            }
        }
    }
    
    func getAchievement(item: Int) {
        if achievementsData[item] == 1 {
            achievementsData[item] = 2
            UserDefaults.standard.setValue(achievementsData, forKey: "achievementsData")
            coinCount += 50
        }
    }
    
}

#Preview {
    Achievements(showAchievements: .constant(true))
}
