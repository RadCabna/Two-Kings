//
//  YouWin.swift
//  Two Kings
//
//  Created by Алкександр Степанов on 20.08.2025.
//

import SwiftUI

struct YouWin: View {
    @AppStorage("levelNumber") var levelNumber = 1
    @AppStorage("taskData") var taskData = 0
    @AppStorage("coinCount") var coinCount = 0
    @Binding var targetArray: [TargetButterfly]
    @State private var levelsData = UserDefaults.standard.array(forKey: "levelsData") as? [Int] ?? Array(repeating: 0, count: 18)
    @State private var baseData = UserDefaults.standard.array(forKey: "baseData") as? [Int] ?? [0,0,0,0,0,0,0]
    @State private var uniqueData = UserDefaults.standard.array(forKey: "uniqueData") as? [Int] ?? [0,0,0,0,0,0,0,0,0]
    @State private var achievementsData = UserDefaults.standard.array(forKey: "achievementsData") as? [Int] ?? [0,0,0,0,0]
    @State private var allCollectedButterflyes = 0
    var body: some View {
        Image(.winFrame)
            .resizable()
            .scaledToFit()
            .frame(width: screenWidth*0.6)
            .overlay(
                VStack {
                    Text("CONGRATULATIONS!")
                        .font(Font.custom("PaytoneOne-Regular", size: screenWidth*0.04))
                        .foregroundColor(.white)
                        .shadow(color: .black, radius: 2)
                        .shadow(color: .black, radius: 2)
                    ZStack {
                        Image(.awardFrame)
                            .resizable()
                            .scaledToFit()
                            .frame(width: screenWidth*0.25)
                        HStack {
                            Text("Award: +\(allCollectedButterflyes*2)")
                                .font(Font.custom("PaytoneOne-Regular", size: screenWidth*0.026))
                                .foregroundColor(.white)
                                .shadow(color: .black, radius: 2)
                                .shadow(color: .black, radius: 2)
                            Image(.awardCoin)
                                .resizable()
                                .scaledToFit()
                                .frame(width: screenWidth*0.03)
                        }
                    }
                    .padding(.bottom, screenWidth*0.03)
                    HStack(spacing: screenWidth*0.05) {
                        Buttons(size: 0.2, text: "Back to Menu")
                            .onTapGesture {
                                updateLevelsData()
                                coinCount += allCollectedButterflyes*2
                                NavGuard.shared.currentScreen = .MENU
                            }
                        Buttons(size: 0.2, text: "Next Level")
                            .onTapGesture {
                                updateLevelsData()
                                coinCount += allCollectedButterflyes*2
                                levelNumber += 1
                                NavGuard.shared.currentScreen = .MENU
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.001) {
                                    NavGuard.shared.currentScreen = .GAME
                                }
                            }
                    }
                }
            )
            .onAppear {
                complexAllButterflyes()
                updateCollectionsData()
                taskData = 1
                achievementsData[0] = 1
                UserDefaults.standard.set(achievementsData, forKey: "achievementsData")
            }
    }
    
    func complexAllButterflyes() {
        for i in 0..<targetArray.count {
            allCollectedButterflyes += targetArray[i].count
        }
    }
    
    func updateLevelsData() {
        levelsData[levelNumber] = 1
        UserDefaults.standard.set(levelsData, forKey: "levelsData")
    }
    
    func updateCollectionsData() {
        switch levelNumber {
        case 1:
            baseData[0] = 1
            baseData[1] = 1
        case 2:
            baseData[2] = 1
            baseData[3] = 1
        case 3:
            baseData[4] = 1
            baseData[5] = 1
        case 4:
            baseData[6] = 1
            uniqueData[0] = 1
        case 5:
            uniqueData[1] = 1
            uniqueData[2] = 1
        case 6:
            uniqueData[3] = 1
            uniqueData[4] = 1
        case 7:
            uniqueData[5] = 1
            uniqueData[6] = 1
        default:
            break
        }
        UserDefaults.standard.set(baseData, forKey: "baseData")
        UserDefaults.standard.set(uniqueData, forKey: "uniqueData")
    }
}

#Preview {
    YouWin(targetArray: .constant([TargetButterfly(count: 3, type: 1, image: "")]))
}
