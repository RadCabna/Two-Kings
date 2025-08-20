//
//  DaylyReward.swift
//  Two Kings
//
//  Created by Алкександр Степанов on 13.08.2025.
//

import SwiftUI

struct DaylyReward: View {
    @State private var rewardData = UserDefaults.standard.array(forKey: "rewardData") as? [Int] ?? [1,0,0,0,0,0,0]
    @AppStorage("coinCount") var coinCount = 0
    @Binding var showDailyReward: Bool
    var body: some View {
        ZStack {
            Image(.dailyRewardFrame)
                .resizable()
                .scaledToFit()
                .frame(width: screenWidth*0.85)
            Image(.crossButton)
                .resizable()
                .scaledToFit()
                .frame(width: screenWidth*0.08)
                .offset(x: screenWidth*0.41, y: -screenWidth*0.145)
                .onTapGesture {
                    showDailyReward.toggle()
                }
            Image(.rewardHeadFrame)
                .resizable()
                .scaledToFit()
                .frame(width: screenWidth*0.3)
                .overlay(
                    Text("DAILY REWARD")
                        .font(Font.custom("PaytoneOne-Regular", size: screenWidth*0.03))
                        .foregroundColor(.white)
                        .shadow(color: .black, radius: 2)
                        .shadow(color: .black, radius: 2)
                        .offset(y: -screenWidth*0.002)
                )
                .offset(y: -screenWidth*0.1)
            HStack {
                ForEach(0..<rewardData.count, id: \.self) { item in
                    if rewardData[item] == 0 {
                        VStack {
                            Image(.closeRewardFrame)
                                .resizable()
                                .scaledToFit()
                                .frame(width: screenWidth*0.1)
                                .overlay(
                                    VStack(spacing: screenWidth*0.005) {
                                        ZStack {
                                            Image(.closeDayFrame)
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: screenWidth*0.07)
                                            Text("Day \(item+1)")
                                                .font(Font.custom("PaytoneOne-Regular", size: screenWidth*0.017))
                                                .foregroundColor(.white)
                                                .shadow(color: .black, radius: 2)
                                        }
                                        Image(.lock)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: screenWidth*0.02)
                                    }
                                )
                            Image(.rewardButtonGrey)
                                .resizable()
                                .scaledToFit()
                                .frame(width: screenWidth*0.1)
                                .overlay(
                                    Text("Closed")
                                        .font(Font.custom("PaytoneOne-Regular", size: screenWidth*0.017))
                                        .foregroundColor(.white)
                                        .shadow(color: .black, radius: 2)
                                )
                        }
                    }
                    if rewardData[item] == 1 {
                        VStack {
                            Image(.closeRewardFrame)
                                .resizable()
                                .scaledToFit()
                                .frame(width: screenWidth*0.1)
                                .overlay(
                                    VStack(spacing: screenWidth*0.005) {
                                        ZStack {
                                            Image(.closeDayFrame)
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: screenWidth*0.07)
                                            Text("Day \(item+1)")
                                                .font(Font.custom("PaytoneOne-Regular", size: screenWidth*0.017))
                                                .foregroundColor(.white)
                                                .shadow(color: .black, radius: 2)
                                        }
                                        HStack(spacing: screenWidth*0.005) {
                                            Text("+10")
                                                .font(Font.custom("PaytoneOne-Regular", size: screenWidth*0.02))
                                                .foregroundColor(.white)
                                                .shadow(color: .black, radius: 2)
                                            Image(.closeCoin)
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: screenWidth*0.02)
                                        }
                                    }
                                )
                            Image(.rewardButton)
                                .resizable()
                                .scaledToFit()
                                .frame(width: screenWidth*0.1)
                                .overlay(
                                    Text("Get")
                                        .font(Font.custom("PaytoneOne-Regular", size: screenWidth*0.017))
                                        .foregroundColor(.white)
                                        .shadow(color: .black, radius: 2)
                                )
                                .onTapGesture {
                                    getBonus(item: item)
                                }
                        }
                    }
                    if rewardData[item] == 2 {
                        VStack {
                            Image(.rewardFrame)
                                .resizable()
                                .scaledToFit()
                                .frame(width: screenWidth*0.1)
                                .overlay(
                                    VStack(spacing: screenWidth*0.005) {
                                        ZStack {
                                            Image(.dayFrame)
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: screenWidth*0.07)
                                            Text("Day \(item+1)")
                                                .font(Font.custom("PaytoneOne-Regular", size: screenWidth*0.017))
                                                .foregroundColor(.white)
                                                .shadow(color: .black, radius: 2)
                                        }
                                        HStack(spacing: screenWidth*0.005) {
                                            Text("+10")
                                                .font(Font.custom("PaytoneOne-Regular", size: screenWidth*0.02))
                                                .foregroundColor(.white)
                                                .shadow(color: .black, radius: 2)
                                            Image(.coin)
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: screenWidth*0.02)
                                        }
                                    }
                                )
                            Image(.rewardButton)
                                .resizable()
                                .scaledToFit()
                                .frame(width: screenWidth*0.1)
                                .overlay(
                                    Text("Recived")
                                        .font(Font.custom("PaytoneOne-Regular", size: screenWidth*0.017))
                                        .foregroundColor(.white)
                                        .shadow(color: .black, radius: 2)
                                )
                        }
                    }
                }
            }
            .offset(y: screenWidth*0.035)
        }
        .offset(y: screenWidth*0.015)
    }
    
    func getBonus(item: Int) {
        if rewardData[item] == 1 {
            rewardData[item] = 2
            coinCount += 10
            UserDefaults.standard.setValue(rewardData, forKey: "rewardData")
        }
    }
    
}

#Preview {
    DaylyReward(showDailyReward: .constant(true))
}
