import SwiftUI

public struct FlyingButterflyView: View {
    @Binding var butterfly: FlyingButterfly
    @State private var wingTimer: Timer?
    @State private var scale: CGFloat = 1
    var onTap: ((FlyingButterfly) -> Void)?
    
    public init(butterfly: Binding<FlyingButterfly>, onTap: ((FlyingButterfly) -> Void)? = nil) {
        self._butterfly = butterfly
        self.onTap = onTap
    }
    
    public var body: some View {
        let rotationAngle = butterfly.movementDirection * 180 / .pi
        Image("butterfly1")
            .resizable()
            .scaledToFit()
            .frame(width: screenWidth * 0.06)
            .scaleEffect(x: scale)
            .rotationEffect(.degrees(rotationAngle+90))
            .colorMultiply(getButterflyColor())
            .position(x: butterfly.xPosition, y: butterfly.yPosition)
            .opacity(butterfly.isVisible ? 1 : 0)
            .onTapGesture {
                if butterfly.isVisible && butterfly.currentPhase != .leaving {
                    withAnimation(.easeInOut(duration: 0.2)) {
                        scale = 1.5
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        onTap?(butterfly)
                    }
                }
            }
            .onAppear {
                startWingAnimation()
            }
            .onDisappear {
                stopWingAnimation()
            }
    }
    
    func startWingAnimation() {
        wingTimer = Timer.scheduledTimer(withTimeInterval: 0.3, repeats: true) { _ in
            wingAnimation()
        }
    }
    
    func stopWingAnimation() {
        wingTimer?.invalidate()
        wingTimer = nil
    }
    
    func wingAnimation() {
        withAnimation(Animation.easeInOut(duration: 0.15)) {
            scale = 0.8
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
            withAnimation(Animation.easeInOut(duration: 0.15)) {
                scale = 1.0
            }
        }
    }
    
    func getButterflyColor() -> Color {
        switch butterfly.colorType {
        case 1:
            return Color.yellow
        case 2:
            return Color.green
        case 3:
            return Color.red
        case 4:
            return Color.white
        case 5:
            return Color.blue
        case 6:
            return Color.orange
        case 7:
            return Color.indigo
        case 8:
            return Color.cyan
        case 9:
            return Color.mint
        case 10:
            return Color.indigo
        case 11:
            return Color.brown
        case 12:
            return Color.teal
        case 15:
            return Color.white
        default:
            return Color.white
        }
    }
}

#Preview {
    @State var sampleButterfly = FlyingButterfly(colorType: 12, xPosition: 100, yPosition: 100)
    return FlyingButterflyView(butterfly: $sampleButterfly) { butterfly in
        print("Tapped butterfly with color \(butterfly.colorType)")
    }
} 
