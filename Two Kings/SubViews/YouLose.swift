//
//  YouLose.swift
//  Two Kings
//
//  Created by Алкександр Степанов on 20.08.2025.
//

import SwiftUI

struct YouLose: View {
    var body: some View {
        ZStack {
            Image(.pauseFrame)
                .resizable()
                .scaledToFit()
                .frame(width: screenWidth*0.45)
                .overlay(
                    VStack {
                        Text("Time's Up!")
                            .font(Font.custom("PaytoneOne-Regular", size: screenWidth*0.05))
                            .foregroundColor(.white)
                            .shadow(color: .black, radius: 2)
                            .shadow(color: .black, radius: 2)
                            .textCase(.uppercase)
                        HStack {
                            Buttons(size: 0.18, text: "Menu", textSize: 1.2)
                                .onTapGesture {
                                    NavGuard.shared.currentScreen = .MENU
                                }
                            Buttons(size: 0.18, text: "Retry", textSize: 1.2)
                                .onTapGesture {
                                    NavGuard.shared.currentScreen = .MENU
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.001) {
                                        NavGuard.shared.currentScreen = .GAME
                                    }
                                }
                        }
                    }
                )
        }
    }
}

#Preview {
    YouLose()
}
