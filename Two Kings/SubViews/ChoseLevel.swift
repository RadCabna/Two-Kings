//
//  ChoseLevel.swift
//  Two Kings
//
//  Created by Алкександр Степанов on 19.08.2025.
//

import SwiftUI

struct ChoseLevel: View {
    @AppStorage("coinCount") var coinCount = 0
    @AppStorage("levelNumber") var levelNumber = 1
    @AppStorage("languageIndex") var languageIndex = 0
    @State private var levelsTextArray = ["Levels", "Livelli", "Level", "Niveles"]
    @State private var levelsData = UserDefaults.standard.array(forKey: "levelsData") as? [Int] ?? Array(repeating: 0, count: 18)
    @Binding var showChoseLevel: Bool
    var body: some View {
        ZStack {
            HStack(alignment: .top) {
                Image(.buttonBack)
                    .resizable()
                    .scaledToFit()
                    .frame(width: screenWidth*0.07)
                    .onTapGesture {
                        showChoseLevel.toggle()
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
                Image(.levelsHeadFrame)
                    .resizable()
                    .scaledToFit()
                    .frame(width: screenWidth*0.25)
                    .overlay(
                        Text(levelsTextArray[languageIndex])
                            .font(Font.custom("PaytoneOne-Regular", size: screenWidth*0.035))
                            .foregroundColor(.white)
                            .shadow(color: .black, radius: 2)
                            .shadow(color: .black, radius: 2)
                        )
                Image(.levelsFrame)
                    .resizable()
                    .scaledToFit()
                    .frame(width: screenWidth*0.6)
                    .overlay(
                        LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 0), count: 6), spacing: 10) {
                            ForEach(0..<18, id: \.self) { index in
                                if levelsData[index] == 1 || index == 0 {
                                    Image(.levelNumberFrame)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: screenWidth*0.075)
                                        .overlay(
                                            Text("\(index+1)")
                                                .font(Font.custom("PaytoneOne-Regular", size: screenWidth*0.045))
                                                .foregroundColor(.white)
                                                .shadow(color: .black, radius: 2)
                                                .shadow(color: .black, radius: 2)
                                                .padding(.bottom, screenWidth*0.01)
                                        )
                                        .onTapGesture {
                                            levelNumber = index+1
                                            NavGuard.shared.currentScreen = .GAME
                                        }
                                } else {
                                    Image(.levelNumberFrame)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: screenWidth*0.075)
                                        .overlay(
                                            Image(.lock)
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: screenWidth*0.03)
                                                .shadow(color: .black, radius: 2)
                                                .shadow(color: .black, radius: 2)
                                        )
                                }
                            }
                        }
                            .frame(maxWidth: screenWidth*0.54)
                    )
            }
        }
    }
}

#Preview {
    ChoseLevel(showChoseLevel: .constant(true))
}
