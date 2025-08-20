//
//  BasicCollect.swift
//  Two Kings
//
//  Created by Алкександр Степанов on 14.08.2025.
//

import SwiftUI

struct BasicCollect: View {
    @AppStorage("coinCount") var coinCount = 0
    @AppStorage("languageIndex") var languageIndex = 0
    @State private var baseArray = ["Base", "Base", "Basis", "Base"]
    @Binding var showBasic: Bool
    var body: some View {
        ZStack {
            HStack(alignment: .top) {
                Image(.buttonBack)
                    .resizable()
                    .scaledToFit()
                    .frame(width: screenWidth*0.07)
                    .onTapGesture {
                        showBasic.toggle()
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
            .padding(.top)
            VStack {
                Image(.rewardHeadFrame)
                    .resizable()
                    .scaledToFit()
                    .frame(width: screenWidth*0.3)
                    .overlay(
                        Text(baseArray[languageIndex])
                            .font(Font.custom("PaytoneOne-Regular", size: screenWidth*0.03))
                            .foregroundColor(.white)
                            .shadow(color: .black, radius: 2)
                            .shadow(color: .black, radius: 2)
                            .textCase(.uppercase)
                            .offset(y: -screenWidth*0.002)
                    )
                Image(.baseFrame)
                    .resizable()
                    .scaledToFit()
                    .frame(width: screenWidth*0.65)
            }
        }
    }
}

#Preview {
    BasicCollect(showBasic: .constant(true))
}
