//
//  Pause.swift
//  Two Kings
//
//  Created by Алкександр Степанов on 19.08.2025.
//

import SwiftUI

struct Pause: View {
    @Binding var pauseTapped: Bool
    var body: some View {
        ZStack {
            Image(.pauseFrame)
                .resizable()
                .scaledToFit()
                .frame(width: screenWidth*0.45)
                .overlay(
                    VStack {
                        Text("PAUSE")
                            .font(Font.custom("PaytoneOne-Regular", size: screenWidth*0.05))
                            .foregroundColor(.white)
                            .shadow(color: .black, radius: 2)
                            .shadow(color: .black, radius: 2)
                        HStack {
                            Buttons(size: 0.18, text: "Menu", textSize: 1.2)
                                .onTapGesture {
                                    NavGuard.shared.currentScreen = .MENU
                                }
                            Buttons(size: 0.18, text: "Continue", textSize: 1.2)
                                .onTapGesture {
                                    pauseTapped.toggle()
                                }
                        }
                    }
                )
        }
    }
}

#Preview {
    Pause(pauseTapped: .constant(true))
}
