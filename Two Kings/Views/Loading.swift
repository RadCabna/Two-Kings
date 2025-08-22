//
//  Loading.swift
//  Kangwon
//
//  Created by Алкександр Степанов on 24.07.2025.
//

import SwiftUI

struct Loading: View {
//    @EnvironmentObject var coordinator: Coordinator
    @State private var loadingOpacity: CGFloat = 0
    @State private var loadingProgress: CGFloat = 1
    var body: some View {
        GeometryReader { geometry in
            let height = geometry.size.height
            let width = geometry.size.width
            let isLandscape = width > height
            if isLandscape {
                ZStack {
                    Image(.loadingBG)
                        .resizable()
                        .ignoresSafeArea()
                    VStack() {
                        Image(.iconApp1)
                            .resizable()
                            .scaledToFit()
                            .frame(width: width*0.2)
                        Text("Your Escape Starts Here.")
                            .font(Font.custom("inter", size: width*0.055))
                            .textCase(.uppercase)
                            .foregroundColor(.white)
                            .shadow(color: .black, radius: 2)
                            .shadow(color: .black, radius: 2)
                        ZStack {
                            Image(.loadingLineBack)
                                .resizable()
                                .scaledToFit()
                                .frame(width: width*0.5)
                            Image(.loadingLineFront)
                                .resizable()
                                .scaledToFit()
                                .frame(width: width*0.495)
                                .offset(x: -width*0.5*loadingProgress)
                                .mask(
                                    Image(.loadingLineFront)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: width*0.495)
                                )
                            Text("LOADING...")
                                .font(Font.custom("inter", size: width*0.025))
                                .foregroundColor(.white)
                        }
                    }
                    .offset(y: height*0.05)
                    .opacity(loadingOpacity)
                }
                .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
            } else {
                ZStack {
                    Image(.loadingBG)
                        .resizable()
                        .ignoresSafeArea()
                    VStack() {
                        Image(.iconApp1)
                            .resizable()
                            .scaledToFit()
                            .frame(width: height*0.2)
                        Text("Your Escape Starts Here.")
                            .font(Font.custom("inter", size: width*0.06))
                            .foregroundColor(.white)
                            .textCase(.uppercase)
                        ZStack {
                            Image(.loadingLineBack)
                                .resizable()
                                .scaledToFit()
                                .frame(width: height*0.5)
                            Image(.loadingLineFront)
                                .resizable()
                                .scaledToFit()
                                .frame(width: height*0.49)
                                .offset(x: -height*0.5*loadingProgress)
                                .mask(
                                    Image(.loadingLineFront)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: height*0.49)
                                )
                            Text("Loading...")
                                .font(Font.custom("inter", size: height*0.025))
                                .foregroundColor(.white)
                        }
                    }
                    .rotationEffect(Angle(degrees: -90))
                    .opacity(loadingOpacity)
                }
                .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
            }
        }
        
        .onAppear {
            loadingProgressAnimation()
        }
        
    }
    
    func loadingProgressAnimation() {
        withAnimation(Animation.easeInOut(duration: 1)) {
         loadingOpacity = 1
        }
        withAnimation(Animation.easeInOut(duration: 5)) {
            loadingProgress = 0
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
//            coordinator.navigate(to: .mainMenu)
        }
    }
    
}

#Preview {
    Loading()
}
