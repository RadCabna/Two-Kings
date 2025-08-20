//
//  Buttons.swift
//  Two Kings
//
//  Created by Алкександр Степанов on 13.08.2025.
//

import SwiftUI

struct Buttons: View {
    var size: CGFloat = 0.25
    var text = "BACKGROUND"
    var textSize: CGFloat = 1
    var body: some View {
        Image("buttonFrame")
             .resizable()
             .scaledToFit()
             .frame(width: screenWidth*size)
             .overlay(
                 Text(text)
                     .font(Font.custom("PaytoneOne-Regular", size: screenWidth*size*0.12*textSize))
                     .foregroundColor(.white)

             )
             .shadow(color:.black, radius: 3, x: 2, y: 2)
    }
}

#Preview {
    Buttons()
}
