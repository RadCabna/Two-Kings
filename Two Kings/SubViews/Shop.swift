//
//  Shop.swift
//  Two Kings
//
//  Created by Алкександр Степанов on 17.08.2025.
//

import SwiftUI

struct Shop: View {
    @AppStorage("coinCount") var coinCount = 0
    @AppStorage("languageIndex") var languageIndex = 0
    @AppStorage("upgradeLevel") var upgradeLevel = 1
    @AppStorage("bgNumber") var bgNumber = 0
    @State private var languageShopArray = Arrays.languageShopArray
    @State private var upgradesTextArray = ["Upgrades", "Miglioramenti", "Upgrades", "Mejoras"]
    @State private var locationsTextArray = ["Locations", "Posizioni", "Standorte", "Ubicaciones"]
    @State private var locationShopArray = Arrays.locationShopArray
    @State private var locationsData = UserDefaults.standard.array(forKey: "locationsData") as? [Int] ?? [2,0,0,0]
    @State private var typeSelect = false
    @State private var selectedType = 0
    @State private var choseShopOpacity: CGFloat = 1
    @State private var upgradesShopOpacity: CGFloat = 0
    @State private var locationsShopOpacity: CGFloat = 0
    @Binding var showShop: Bool
    var body: some View {
        ZStack {
            HStack(alignment: .top) {
                Image(.buttonBack)
                    .resizable()
                    .scaledToFit()
                    .frame(width: screenWidth*0.07)
                    .onTapGesture {
                        if !typeSelect {
                            showShop.toggle()
                        } else {
                            typeSelect = false
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
            if !typeSelect {
                Image(.choseShopFrame)
                    .resizable()
                    .scaledToFit()
                    .frame(width: screenWidth*0.4)
                    .overlay(
                        VStack {
                            ZStack {
                                Image(.shopHeadFrame)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: screenWidth*0.2)
                                Text(languageShopArray[languageIndex][0])
                                    .font(Font.custom("PaytoneOne-Regular", size: screenWidth*0.03))
                                    .foregroundColor(.white)
                                    .shadow(color: .black, radius: 2)
                                    .shadow(color: .black, radius: 2)
                                    .textCase(.uppercase)
                            }
                            Buttons(text: "UPGRADES")
                                .onTapGesture {
                                    selectedType = 0
                                    typeSelect = true
                                    changeViewAnimation()
                                }
                            Buttons(text: "LOCATIONS")
                                .onTapGesture {
                                    selectedType = 1
                                    typeSelect = true
                                    changeViewAnimation()
                                }
                        }
                    )
                    .offset(y: screenWidth*0.03)
                    .opacity(choseShopOpacity)
            } else if selectedType == 0 {
                VStack {
                    Image(.upgradeHeadFrame)
                        .resizable()
                        .scaledToFit()
                        .frame(width: screenWidth*0.25)
                        .overlay(
                            Text(upgradesTextArray[languageIndex])
                                .font(Font.custom("PaytoneOne-Regular", size: screenWidth*0.025))
                                .foregroundColor(.white)
                                .shadow(color: .black, radius: 2)
                                .shadow(color: .black, radius: 2)
                                .textCase(.uppercase)
                        )
                    ZStack {
                        Image(.upgradesFrame)
                            .resizable()
                            .scaledToFit()
                            .frame(width: screenWidth*0.6)
                        VStack {
                            Text("Level \(upgradeLevel)")
                                .font(Font.custom("PaytoneOne-Regular", size: screenWidth*0.035))
                                .foregroundColor(.white)
                                .shadow(color: .black, radius: 2)
                                .shadow(color: .black, radius: 2)
//                            Lighting Radius - 10
                            VStack(alignment: .leading) {
                                Text("Lighting Radius - 10")
                                    .font(Font.custom("PaytoneOne-Regular", size: screenWidth*0.02))
                                    .foregroundColor(.white)
                                    .shadow(color: .black, radius: 2)
                                    .shadow(color: .black, radius: 2)
                                Text("Base Brightness - 30% / 0%")
                                    .font(Font.custom("PaytoneOne-Regular", size: screenWidth*0.02))
                                    .foregroundColor(.white)
                                    .shadow(color: .black, radius: 2)
                                    .shadow(color: .black, radius: 2)
                                Text("(visual / % increase over standard butterflies)")
                                    .font(Font.custom("PaytoneOne-Regular", size: screenWidth*0.01))
                                    .foregroundColor(.white)
                                    .shadow(color: .black, radius: 2)
                                    .shadow(color: .black, radius: 2)
                                Text("Unlocked Colors - 3")
                                    .font(Font.custom("PaytoneOne-Regular", size: screenWidth*0.02))
                                    .foregroundColor(.white)
                                    .shadow(color: .black, radius: 2)
                                    .shadow(color: .black, radius: 2)
                                Text("Pollen consumption - 0% (10/20 pollen/sec)")
                                    .font(Font.custom("PaytoneOne-Regular", size: screenWidth*0.02))
                                    .foregroundColor(.white)
                                    .shadow(color: .black, radius: 2)
                                    .shadow(color: .black, radius: 2)
                            }
                            Image(coinCount >= 100 ? .upgradeButtonOn : .upgradeButtonOff)
                                .resizable()
                                .scaledToFit()
                                .frame(width: screenWidth*0.15)
                                .overlay(
                                    VStack(spacing: 0) {
                                        Text("Upgrade")
                                            .font(Font.custom("PaytoneOne-Regular", size: screenWidth*0.015))
                                            .foregroundColor(.white)
                                            .shadow(color: .black, radius: 2)
                                        HStack {
                                            Image(.coin)
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: screenWidth*0.02)
                                            Text("100")
                                                .font(Font.custom("PaytoneOne-Regular", size: screenWidth*0.017))
                                                .foregroundColor(.white)
                                                .shadow(color: .black, radius: 2)
                                        }
                                    }
                                )
                                .onTapGesture {
                                    if coinCount >= 100 {
                                        coinCount -= 100
                                        upgradeLevel += 1
                                    }
                                }
                        }
                    }
                }
                .opacity(upgradesShopOpacity)
            } else {
                VStack(spacing: screenWidth*0.03) {
                    Image(.upgradeHeadFrame)
                        .resizable()
                        .scaledToFit()
                        .frame(width: screenWidth*0.25)
                        .overlay(
                            Text(locationsTextArray[languageIndex])
                                .font(Font.custom("PaytoneOne-Regular", size: screenWidth*0.025))
                                .foregroundColor(.white)
                                .shadow(color: .black, radius: 2)
                                .shadow(color: .black, radius: 2)
                                .textCase(.uppercase)
                        )
                    HStack(spacing: screenWidth*0.04) {
                        ForEach(0..<locationShopArray.count, id: \.self) { item in
                            VStack {
                                Image(locationShopArray[item])
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: screenWidth*0.13)
                                    if locationsData[item] == 0 {
                                        if coinCount >= 100 {
                                            Image(.upgradeButtonOn)
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: screenWidth*0.14)
                                                .overlay(
                                                    VStack(spacing: 0) {
                                                        Text("Buy")
                                                            .font(Font.custom("PaytoneOne-Regular", size: screenWidth*0.017))
                                                            .foregroundColor(.white)
                                                            .shadow(color: .black, radius: 2)
                                                            .shadow(color: .black, radius: 2)
                                                        HStack {
                                                            Image(.coin)
                                                                .resizable()
                                                                .scaledToFit()
                                                                .frame(width: screenWidth*0.015)
                                                            Text("100")
                                                                .font(Font.custom("PaytoneOne-Regular", size: screenWidth*0.015))
                                                                .foregroundColor(.white)
                                                                .shadow(color: .black, radius: 2)
                                                        }
                                                    }
                                                )
                                        } else {
                                            Image(.upgradeButtonOff)
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: screenWidth*0.14)
                                                .overlay(
                                                    VStack(spacing: 0) {
                                                        Text("Buy")
                                                            .font(Font.custom("PaytoneOne-Regular", size: screenWidth*0.017))
                                                            .foregroundColor(.white)
                                                            .shadow(color: .black, radius: 2)
                                                            .shadow(color: .black, radius: 2)
                                                        HStack {
                                                            Image(.coin)
                                                                .resizable()
                                                                .scaledToFit()
                                                                .frame(width: screenWidth*0.015)
                                                            Text("100")
                                                                .font(Font.custom("PaytoneOne-Regular", size: screenWidth*0.015))
                                                                .foregroundColor(.white)
                                                                .shadow(color: .black, radius: 2)
                                                        }
                                                    }
                                                )
                                                .onTapGesture {
                                                    buyItem(item: item)
                                                }
                                        }
                                    }
                                if locationsData[item] == 1 {
                                    Image(.upgradeButtonOn)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: screenWidth*0.14)
                                        .overlay(
                                                Text("Select")
                                                    .font(Font.custom("PaytoneOne-Regular", size: screenWidth*0.023))
                                                    .foregroundColor(.white)
                                                    .shadow(color: .black, radius: 2)
                                                    .shadow(color: .black, radius: 2)
                                                )
                                        .onTapGesture {
                                            selectItem(item: item)
                                        }
                                }
                                if locationsData[item] == 2 {
                                    Image(.upgradeButtonOn)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: screenWidth*0.14)
                                        .overlay(
                                                Text("Selected")
                                                    .font(Font.custom("PaytoneOne-Regular", size: screenWidth*0.023))
                                                    .foregroundColor(.white)
                                                    .shadow(color: .black, radius: 2)
                                                    .shadow(color: .black, radius: 2)
                                                )
                                }
                            }
                        }
                    }
                }
                .opacity(locationsShopOpacity)
            }
        }
    }
    
    func changeViewAnimation() {
        if typeSelect {
            withAnimation(Animation.easeInOut(duration: 0.2)) {
                choseShopOpacity = 0
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                if selectedType == 0 {
                    withAnimation(Animation.easeInOut(duration: 0.2)) {
                        upgradesShopOpacity = 1
                    }
                } else {
                    withAnimation(Animation.easeInOut(duration: 0.2)) {
                        locationsShopOpacity = 1
                    }
                }
            }
        } else {
            withAnimation(Animation.easeInOut(duration: 0.2)) {
                upgradesShopOpacity = 0
                locationsShopOpacity = 0
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                withAnimation(Animation.easeInOut(duration: 0.2)) {
                    choseShopOpacity = 1
                }
            }
        }
    }
    
    func buyItem(item: Int) {
        if coinCount >= 100 {
            coinCount -= 100
            locationsData[item] = 1
            UserDefaults.standard.set(locationsData, forKey: "locationsData")
        }
    }
    func selectItem(item: Int) {
        if locationsData[item] == 1 {
            for i in 0..<locationsData.count {
                if locationsData[i] == 2 {
                    locationsData[i] = 1
                }
            }
            locationsData[item] = 2
            bgNumber = item+1
            UserDefaults.standard.set(locationsData, forKey: "locationsData")
        }
    }
}

#Preview {
    Shop(showShop: .constant(true))
}
