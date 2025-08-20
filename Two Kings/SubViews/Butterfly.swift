import SwiftUI

struct Butterfly: View {
    @State private var flyTimer: Timer?
    var image = "butterfly1"
    @State private var scale: CGFloat = 1
    var body: some View {
       Image(image)
            .resizable()
            .scaledToFit()
            .frame(width: screenWidth*0.06)
            .scaleEffect(x: scale)
            .onAppear {
                startFlyTimer()
            }
    }
    
    func startFlyTimer() {
        flyTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            flyAnimation()
        }
    }
    
    func flyAnimation() {
        withAnimation(Animation.easeInOut(duration: 0.2)) {
            scale = 0.2
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            withAnimation(Animation.easeInOut(duration: 0.4)) {
                scale = 1
            }
        }
    }
    
}

#Preview {
    Butterfly()
}
