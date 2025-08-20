//
//  ChoseCollection.swift
//  Two Kings
//
//  Created by Алкександр Степанов on 14.08.2025.
//

import SwiftUI

struct ChoseCollection: View {
    @AppStorage("coinCount") var coinCount = 0
    @AppStorage("languageIndex") var languageIndex = 0
    @State private var languageChoseCollestionArray = Arrays.languageChoseCollestionArray
    @State private var baseArray = ["Base", "Base", "Basis", "Base"]
    @State private var uniqueArray = ["Unique", "Unico", "Einzigartig", "Único"]
    @State private var collectionChosen = false
    @State private var collectionIndex = 0
    @State private var choseOpacity: CGFloat = 1
    @State private var baseOpacity: CGFloat = 0
    @State private var uniqueOpacity: CGFloat = 0
    @State private var baseButterflyNameArray = Arrays.baseButterflyNameArray
    @State private var baseData = UserDefaults.standard.array(forKey: "baseData") as? [Int] ?? [0,0,0,0,0,0,0]
    @State private var uniqueButterflyNameArray = Arrays.uniqueButterflyNameArray
    @State private var uniqueData = UserDefaults.standard.array(forKey: "uniqueData") as? [Int] ?? [0,0,0,0,0,0,0,0,0]
    @Binding var showCollection: Bool
    var body: some View {
        ZStack {
            HStack(alignment: .top) {
                Image(.buttonBack)
                    .resizable()
                    .scaledToFit()
                    .frame(width: screenWidth*0.07)
                    .onTapGesture {
                        if !collectionChosen {
                            showCollection.toggle()
                        } else {
                            collectionChosen = false
                            changeViewAnimation()
                        }
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
            if !collectionChosen {
                Image(.selectCollectionFrame)
                    .resizable()
                    .scaledToFit()
                    .frame(width: screenWidth*0.55)
                    .overlay(
                        VStack {
                            Image(.rewardHeadFrame)
                                .resizable()
                                .scaledToFit()
                                .frame(width: screenWidth*0.3)
                                .overlay(
                                    Text(languageChoseCollestionArray[languageIndex][0])
                                        .font(Font.custom("PaytoneOne-Regular", size: screenWidth*0.022))
                                        .foregroundColor(.white)
                                        .shadow(color: .black, radius: 2)
                                        .shadow(color: .black, radius: 2)
                                        .textCase(.uppercase)
                                        .offset(y: -screenWidth*0.002)
                                )
                                .offset(y: -screenWidth*0.05)
                            HStack {
                                Buttons(size: 0.23, text: languageChoseCollestionArray[languageIndex][1], textSize: 1.4)
                                    .onTapGesture {
                                        collectionIndex = 0
                                        collectionChosen = true
                                        changeViewAnimation()
                                    }
                                Spacer()
                                Buttons(size: 0.23, text: languageChoseCollestionArray[languageIndex][2], textSize: 1.4)
                                    .onTapGesture {
                                        collectionIndex = 1
                                        collectionChosen = true
                                        changeViewAnimation()
                                    }
                            }
                            .frame(maxWidth: screenWidth*0.48)
                        }
                    )
                    .offset(y: screenWidth*0.03)
                    .opacity(choseOpacity)
            } else if collectionIndex == 0 {
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
                        .overlay(
                            VStack {
                                HStack {
                                    ForEach(0..<4, id: \.self) { item in
                                        VStack {
                                            ZStack {
                                                Image(.dayFrame)
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(width: screenWidth*0.09)
                                                Image(baseData[item] == 0 ? baseButterflyNameArray[item].imageNotActive : baseButterflyNameArray[item].imageActive)
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(width: screenWidth*0.08)
                                                    .mask(
                                                        Image(.dayFrame)
                                                            .resizable()
                                                            .scaledToFit()
                                                            .frame(width: screenWidth*0.08)
                                                    )
                                            }
                                            Text(baseButterflyNameArray[item].name)
                                                .font(Font.custom("PaytoneOne-Regular", size: screenWidth*0.02))
                                                .foregroundColor(.white)
                                                .shadow(color: .black, radius: 2)
                                        }
                                        .frame(minWidth: screenWidth*0.145)
                                    }
                                }
                                HStack {
                                    ForEach(4..<7, id: \.self) { item in
                                        VStack {
                                            ZStack {
                                                Image(.dayFrame)
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(width: screenWidth*0.09)
                                                Image(baseData[item] == 0 ? baseButterflyNameArray[item].imageNotActive : baseButterflyNameArray[item].imageActive)
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(width: screenWidth*0.08)
                                                    .mask(
                                                        Image(.dayFrame)
                                                            .resizable()
                                                            .scaledToFit()
                                                            .frame(width: screenWidth*0.08)
                                                    )
                                            }
                                            Text(baseButterflyNameArray[item].name)
                                                .font(Font.custom("PaytoneOne-Regular", size: screenWidth*0.017))
                                                .foregroundColor(.white)
                                                .shadow(color: .black, radius: 2)
                                        }
                                        .frame(minWidth: screenWidth*0.15)
                                    }
                                }
                            }
                        )
                }
                .opacity(baseOpacity)
            } else if collectionIndex == 1 {
                VStack {
                    Image(.rewardHeadFrame)
                        .resizable()
                        .scaledToFit()
                        .frame(width: screenWidth*0.3)
                        .overlay(
                            Text(uniqueArray[languageIndex])
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
                        .frame(width: screenWidth*0.85)
                        .overlay(
                            VStack {
                                HStack {
                                    ForEach(0..<5, id: \.self) { item in
                                        VStack {
                                            ZStack {
                                                Image(.dayFrame)
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(width: screenWidth*0.09)
                                                Image(uniqueData[item] == 0 ? uniqueButterflyNameArray[item].imageNotActive : uniqueButterflyNameArray[item].imageActive)
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(width: screenWidth*0.08)
                                                    .mask(
                                                        Image(.dayFrame)
                                                            .resizable()
                                                            .scaledToFit()
                                                            .frame(width: screenWidth*0.08)
                                                    )
                                            }
                                            Text(uniqueButterflyNameArray[item].name)
                                                .font(Font.custom("PaytoneOne-Regular", size: screenWidth*0.02))
                                                .foregroundColor(.white)
                                                .shadow(color: .black, radius: 2)
                                        }
                                        .frame(minWidth: screenWidth*0.145)
                                    }
                                }
                                HStack {
                                    ForEach(5..<9, id: \.self) { item in
                                        VStack {
                                            ZStack {
                                                Image(.dayFrame)
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(width: screenWidth*0.09)
                                                Image(uniqueData[item] == 0 ? uniqueButterflyNameArray[item].imageNotActive : uniqueButterflyNameArray[item].imageActive)
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(width: screenWidth*0.08)
                                                    .mask(
                                                        Image(.dayFrame)
                                                            .resizable()
                                                            .scaledToFit()
                                                            .frame(width: screenWidth*0.08)
                                                    )
                                            }
                                            Text(uniqueButterflyNameArray[item].name)
                                                .font(Font.custom("PaytoneOne-Regular", size: screenWidth*0.017))
                                                .foregroundColor(.white)
                                                .shadow(color: .black, radius: 2)
                                        }
                                        .frame(minWidth: screenWidth*0.15)
                                    }
                                }
                            }
                        )
                }
                .opacity(uniqueOpacity)
            }
        }
    }
    
    func changeViewAnimation() {
        if collectionChosen {
            withAnimation(Animation.easeInOut(duration: 0.2)) {
                choseOpacity = 0
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                if collectionIndex == 0 {
                    withAnimation(Animation.easeInOut(duration: 0.2)) {
                        baseOpacity = 1
                    }
                } else {
                    withAnimation(Animation.easeInOut(duration: 0.2)) {
                        uniqueOpacity = 1
                    }
                }
            }
        } else {
            withAnimation(Animation.easeInOut(duration: 0.2)) {
                baseOpacity = 0
                uniqueOpacity = 0
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                withAnimation(Animation.easeInOut(duration: 0.2)) {
                    choseOpacity = 1
                }
            }
        }
    }
    
}

#Preview {
    ChoseCollection(showCollection: .constant(true))
}
