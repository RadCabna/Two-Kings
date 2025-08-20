//
//  DailyTask.swift
//  Two Kings
//
//  Created by Алкександр Степанов on 20.08.2025.
//

import SwiftUI

struct DailyTask: View {
    @AppStorage("coinCount") var coinCount = 0
    @AppStorage("languageIndex") var languageIndex = 0
    @AppStorage("taskData") var taskData = 0
    @State private var dailyTaskTextArray = ["Daily Task", "Compito Giornaliero", "Tägliche Aufgabe", "Tarea Diaria"]
    @Binding var showTask: Bool
    var body: some View {
        ZStack {
            HStack(alignment: .top) {
                Image(.buttonBack)
                    .resizable()
                    .scaledToFit()
                    .frame(width: screenWidth*0.07)
                    .onTapGesture {
                        showTask.toggle()
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
                        Text(dailyTaskTextArray[languageIndex])
                            .font(Font.custom("PaytoneOne-Regular", size: screenWidth*0.025))
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
                        VStack(spacing: screenWidth*0.015) {
                            Text("Task: Turn on 3 ")
                                .font(Font.custom("PaytoneOne-Regular", size: screenWidth*0.03))
                                .foregroundColor(.white)
                                .shadow(color: .black, radius: 2)
                                .shadow(color: .black, radius: 2)
                                .multilineTextAlignment(.center)
                            Text("lights in one level")
                                .font(Font.custom("PaytoneOne-Regular", size: screenWidth*0.03))
                                .foregroundColor(.white)
                                .shadow(color: .black, radius: 2)
                                .shadow(color: .black, radius: 2)
                                .multilineTextAlignment(.center)
                            ZStack {
                                Image(.awardFrame)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: screenWidth*0.25)
                                HStack {
                                    Text("Award: +10")
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
                            if taskData == 0 {
                                Image(.taskButtonOff)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: screenWidth*0.2)
                                    .overlay(
                                        Text("Closed")
                                            .font(Font.custom("PaytoneOne-Regular", size: screenWidth*0.026))
                                            .foregroundColor(.white)
                                            .shadow(color: .black, radius: 2)
                                            .shadow(color: .black, radius: 2)
                                    )
                            }
                            if taskData == 1 {
                                Image(.taskButtonOn)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: screenWidth*0.2)
                                    .overlay(
                                        Text("GET")
                                            .font(Font.custom("PaytoneOne-Regular", size: screenWidth*0.026))
                                            .foregroundColor(.white)
                                            .shadow(color: .black, radius: 2)
                                            .shadow(color: .black, radius: 2)
                                    )
                                    .onTapGesture {
                                        taskData = 2
                                        coinCount += 10
                                    }
                            }
                            if taskData == 2 {
                                Image(.taskButtonOn)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: screenWidth*0.2)
                                    .overlay(
                                        Text("Recived")
                                            .font(Font.custom("PaytoneOne-Regular", size: screenWidth*0.026))
                                            .foregroundColor(.white)
                                            .shadow(color: .black, radius: 2)
                                            .shadow(color: .black, radius: 2)
                                    )
                            }
                        }
                            .frame(maxWidth: screenWidth*0.3)
                    )
            }
            .offset(y: screenWidth*0.02)
        }
    }
}

#Preview {
    DailyTask(showTask: .constant(true))
}
