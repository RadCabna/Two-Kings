import SwiftUI

struct Game: View {
    @AppStorage("bgNumber") var bgNumber = 1
    @AppStorage("levelNumber") var levelNumber = 1
    @AppStorage("coinCount") var coinCount = 0
    @State private var elapsedTime = 60
    @State private var gameTimer: Timer?
    @State private var targetButtterfly = Arrays.butterfliesArray1
    @State private var lanternCoordinates = Arrays.lanternCoordinates
    @State private var lightCoordinates = Arrays.lightCoordinates
    @State private var lanternArray = Arrays.lantern
    @State private var lightsArray = Arrays.lights
    @State private var allLevelsArray = Arrays.allLevelsArray
    @State private var lanternShadowRadius: CGFloat = 10
    @State private var offset = CGSize.zero
    @State private var position = CGSize.zero
    @State private var isDragging = false
    @State private var dragLanternOpacity: CGFloat = 0
    @State private var dragLanternXOffset: Double = 0
    @State private var dragLanternYOffset: Double = 0
    @StateObject private var butterflyManager = ButterflyManager()
    @State private var catchEffects: [CatchEffect] = []
    @State private var shadowOpacity:CGFloat = 0
    @State private var pauseTapped: Bool = false
    @State private var youWin = false
    @State private var youLose = false
    var body: some View {
        ZStack {
            Backgrouns(backgroundNumber: bgNumber)
            HStack(alignment: .top) {
                Image(.pauseButton)
                    .resizable()
                    .scaledToFit()
                    .frame(width: screenWidth*0.07)
                    .onTapGesture {
                        pauseTapped.toggle()
                    }
                Spacer()
                Image(.timerFrame)
                    .resizable()
                    .scaledToFit()
                    .frame(width: screenWidth*0.2)
                    .overlay(
                        Text(formatTime(elapsedTime))
                            .font(Font.custom("PaytoneOne-Regular", size: screenWidth*0.03))
                            .foregroundColor(.white)
                            .shadow(color: .black, radius: 2)
                            .shadow(color: .black, radius: 2)
                            .offset(x: screenWidth*0.02)
                    )
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
            ForEach(0..<lightsArray.count, id: \.self) { item in
                if lightsArray[item].colorType != 0 {
                    Image(lightColor(item: item))
                        .resizable()
                        .scaledToFit()
                        .frame(width: screenWidth*0.2)
                        .offset(x: lightsArray[item].xPosition, y: lightsArray[item].yPosition)
                }
            }
            ForEach(0..<lanternArray.count, id: \.self) { item in
                if lanternArray[item].colorType != 0 {
                    ZStack {
                        Image(lanternLight(item: item))
                            .resizable()
                            .scaledToFit()
                            .frame(width: screenWidth*0.17)
                            .offset(y: -screenWidth*0.015)
                        Image(lanternImage(item: item))
                            .resizable()
                            .scaledToFit()
                            .frame(width: screenWidth*0.06)
                            .gesture(
                                DragGesture()
                                    .onEnded { value in
                                        let oldColor = lanternArray[item].colorType
                                        if value.translation.width > 10 {
                                            if lanternArray[item].colorType < 7 {
                                                lanternArray[item].colorType += 1
                                            } else {
                                                lanternArray[item].colorType = 1
                                            }
                                        }
                                        if value.translation.width < 10 {
                                            if lanternArray[item].colorType > 1 {
                                                lanternArray[item].colorType -= 1
                                            } else {
                                                lanternArray[item].colorType = 7
                                            }
                                        }
                                        if oldColor != lanternArray[item].colorType {
                                            updateButterflyForChangedLantern(index: item)
                                        }
                                    }
                            )
                        
                        ZStack {
                            Image(.lanternLifeBack)
                                .resizable()
                                .scaledToFit()
                                .frame(width: screenWidth*0.09)
                            Image(.lanternLifeFront)
                                .resizable()
                                .scaledToFit()
                                .frame(width: screenWidth*0.085)
                                .offset(x: -screenWidth*0.09*(1-CGFloat(lanternArray[item].life)/100))
                                .mask(
                                    Image(.lanternLifeFront)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: screenWidth*0.085)
                                )
                            Text("\(lanternArray[item].life)%")
                                .font(Font.custom("PaytoneOne-Regular", size: screenWidth*0.008))
                                .foregroundColor(.white)
                                .shadow(color: .black, radius: 2)
                        }
                        .offset(y: screenWidth*0.045)
                    }
                    .offset(x: lanternArray[item].xPosition, y: lanternArray[item].yPosition)
                }
            }
            Image(.lanternOff)
                .resizable()
                .scaledToFit()
                .frame(width: screenWidth*0.06)
                .opacity(dragLanternOpacity)
                .offset(x: dragLanternXOffset + offset.width, y: dragLanternYOffset + offset.height)
            Image(.lanternOff)
                .resizable()
                .scaledToFit()
                .frame(width: screenWidth*0.04)
                .shadow(color: .white, radius: lanternShadowRadius)
                .shadow(color: .white, radius: lanternShadowRadius)
                .gesture(
                        DragGesture()
                            .onChanged { value in
                                dragLanternOpacity = 1
                                isDragging = true
                                dragLanternXOffset = 387
                                dragLanternYOffset = 168
                                offset = value.translation
                            }
                            .onEnded { value in
                                isDragging = false
                                dragLanternXOffset += value.translation.width
                                dragLanternYOffset += value.translation.height
                                offset = .zero
                                dragLanternOpacity = 0
                                dropNewLantern()
                                print("Фонарь перемещен: x = \(Int(dragLanternXOffset)), y = \(Int(dragLanternYOffset))")
                            }
                    )
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
            HStack {
                ForEach(0..<targetButtterfly.count, id: \.self) { item in
                    ZStack {
                        Image(.targetBFFrame)
                            .resizable()
                            .scaledToFit()
                            .frame(width: screenWidth*0.06)
                        Image("butterfly1")
                            .resizable()
                            .scaledToFit()
                            .frame(width: screenWidth * 0.05)
                            .colorMultiply(getButterflyColor(colorType: targetButtterfly[item].type))
                        Image(.bfCountFrame)
                            .resizable()
                            .scaledToFit()
                            .frame(width: screenWidth*0.025)
                            .overlay(
                                Text("\(targetButtterfly[item].count)")
                                    .font(Font.custom("PaytoneOne-Regular", size: screenWidth*0.015))
                                    .foregroundColor(.white)
                                    .shadow(color: .black, radius: 2)
                            )
                            .offset(x: screenWidth*0.03, y: -screenWidth*0.03)
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomLeading)
            .padding(.horizontal)
            ForEach(butterflyManager.flyingButterflies.indices, id: \.self) { index in
                FlyingButterflyView(butterfly: $butterflyManager.flyingButterflies[index]) { butterfly in
                    catchButterfly(butterfly)
                }
            }
            ForEach(catchEffects) { effect in
                Image(systemName: "sparkles")
                    .font(.system(size: 30))
                    .foregroundColor(.yellow)
                    .opacity(effect.opacity)
                    .scaleEffect(effect.scale)
                    .position(effect.position)
            }
            Color.black.ignoresSafeArea().opacity(shadowOpacity)
            
            if pauseTapped {
                Pause(pauseTapped: $pauseTapped)
            }
            if youWin {
                YouWin(targetArray: $targetButtterfly)
            }
            if youLose {
                YouLose()
            }
        }
        .onAppear {
            updateGameLevel()
            updateLanternPosition()
            updateLightsPosition()
            updateButterflyManagerPositions()
            lanternBlink()
            startGameTimer()
        }
        .onChange(of: lanternArray) { _ in
            mixColors()
            updateButterflyManagerPositions()
            butterflyManager.validateButterfliesTargets(lanterns: lanternArray, lights: lightsArray)
        }
        .onChange(of: lightsArray) { _ in
            butterflyManager.validateButterfliesTargets(lanterns: lanternArray, lights: lightsArray)
        }
        .onChange(of: pauseTapped) { _ in
            if pauseTapped {
                showSubViewAnimation()
                stopAllTimers()
            } else {
                hideSubViewAnimation()
                restartAllTimers()
            }
        }
        .onChange(of: youLose) { _ in
            if youLose {
                showSubViewAnimation()
                stopAllTimers()
            } else {
                hideSubViewAnimation()
                restartAllTimers()
            }
        }
        .onChange(of: youWin) { _ in
            if youWin {
                showSubViewAnimation()
                stopAllTimers()
            } else {
                hideSubViewAnimation()
                restartAllTimers()
            }
        }
        
        .onChange(of: elapsedTime) { _ in
            if elapsedTime <= 0 {
                if targetButtterfly.contains(where: { $0.count == 0 }) {
                    youLose = true
                } else {
                    youWin = true
                }
            }
        }
        
    }
    
    func updateGameLevel() {
        switch levelNumber {
        case 1:
            targetButtterfly = allLevelsArray[0]
        case 2:
            targetButtterfly = allLevelsArray[1]
        case 3:
            targetButtterfly = allLevelsArray[2]
        case 4:
            targetButtterfly = allLevelsArray[3]
        case 5:
            targetButtterfly = allLevelsArray[4]
        case 6:
            targetButtterfly = allLevelsArray[5]
        case 7:
            targetButtterfly = allLevelsArray[6]
        case 8:
            targetButtterfly = allLevelsArray[7]
        case 9:
            targetButtterfly = allLevelsArray[8]
        case 10:
            targetButtterfly = allLevelsArray[9]
        case 11:
            targetButtterfly = allLevelsArray[10]
        case 12:
            targetButtterfly = allLevelsArray[11]
        case 13:
            targetButtterfly = allLevelsArray[12]
        case 14:
            targetButtterfly = allLevelsArray[13]
        case 15:
            targetButtterfly = allLevelsArray[14]
        case 16:
            targetButtterfly = allLevelsArray[15]
        case 17:
            targetButtterfly = allLevelsArray[16]
        case 18:
            targetButtterfly = allLevelsArray[17]
        default:
            targetButtterfly = allLevelsArray[1]
        }
    }
    
    func showSubViewAnimation() {
        withAnimation(Animation.easeInOut(duration: 0.5)) {
            shadowOpacity = 0.5
        }
    }
    
    func hideSubViewAnimation() {
        withAnimation(Animation.easeInOut(duration: 0.5)) {
            shadowOpacity = 0
        }
    }
    
    func stopAllTimers() {
        stopGameTimer()
        for i in 0..<lanternArray.count {
            if lanternArray[i].colorType != 0 {
                lanternArray[i].lifeTimer?.invalidate()
            }
        }
    }
    
    func restartAllTimers() {
        startGameTimer()
        for i in 0..<lanternArray.count {
            if lanternArray[i].colorType != 0 {
                startLanternLifeDecrease(item: i)
            }
        }
    }
    
    func formatTime(_ totalSeconds: Int) -> String {
        let minutes = totalSeconds / 60
        let seconds = totalSeconds % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    func colorMixer(color1: Int, color2: Int) -> Int {
        switch (color1, color2) {
        case (3,4):
            return 8
        case (4,3):
            return 8
        case (2,4):
            return 9
        case (4,2):
            return 9
        case (5,1):
            return 10
        case (1,5):
            return 10
        case (2,1):
            return 11
        case (1,2):
            return 11
        case (5,4):
            return 12
        case (4,5):
            return 12
        case (3,5):
            return 7
        case (5,3):
            return 7
        case (3,1):
            return 6
        case (1,3):
            return 6
        case (6,7):
            return 15
        case (7,6):
            return 15
        default:
            return 0
        }
    }
    
    func getButterflyColor(colorType: Int) -> Color {
        switch colorType {
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
    
    func mixColors() {
        let previousLights = lightsArray.map { $0.colorType }
        for i in 0..<5 {
            if lanternArray[i].colorType != 0 &&
                lanternArray[i+1].colorType != 0 {
                lightsArray[i].colorType = colorMixer(color1: lanternArray[i].colorType, color2: lanternArray[i+1].colorType)
            } else {
                lightsArray[i].colorType = 0
            }
        }
        for i in 5..<11 {
            if lanternArray[i-5].colorType != 0 &&
                lanternArray[i+1].colorType != 0 {
                lightsArray[i].colorType = colorMixer(color1: lanternArray[i-5].colorType, color2: lanternArray[i+1].colorType)
            } else {
                lightsArray[i].colorType = 0
            }
        }
        for i in 11..<16 {
            if lanternArray[i-5].colorType != 0 &&
                lanternArray[i-4].colorType != 0 {
                lightsArray[i].colorType = colorMixer(color1: lanternArray[i-5].colorType, color2: lanternArray[i-4].colorType)
            } else {
                lightsArray[i].colorType = 0
            }
        }
        for i in 0..<lightsArray.count {
            let previousColor = previousLights[i]
            let currentColor = lightsArray[i].colorType
            let lightIndex = lanternArray.count + i
            if previousColor != currentColor {
                if previousColor != 0 {
                    butterflyManager.removeButterflyForLantern(lanternIndex: lightIndex)
                }
                if currentColor != 0 {
                    let lightPosition = CGPoint(
                        x: lightsArray[i].xPosition + screenWidth / 2,
                        y: lightsArray[i].yPosition + screenHeight / 2
                    )
                    butterflyManager.spawnButterflyForLantern(
                        colorType: currentColor,
                        lanternIndex: lightIndex,
                        lanternPosition: lightPosition
                    )
                }
            }
        }
        lightsArray = lightsArray
    }
    
    func dropNewLantern() {
        for i in 0..<lanternArray.count {
            if lanternArray[i].xPosition + 52.0 > dragLanternXOffset &&
                lanternArray[i].xPosition - 52.0 < dragLanternXOffset &&
                lanternArray[i].yPosition + 61.0 > dragLanternYOffset &&
                lanternArray[i].yPosition - 61.0 < dragLanternYOffset &&
                lanternArray[i].colorType == 0 {
                lanternArray[i].colorType = 1
                startLanternLifeDecrease(item: i)
                spawnButterflyForLantern(index: i)
            }
        }
    }
    
    func startLanternLifeDecrease(item: Int) {
        lanternArray[item].lifeTimer = Timer.scheduledTimer(withTimeInterval: 0.4, repeats: true) { _ in
            if lanternArray[item].life > 0 {
                lanternArray[item].life -= 1
            } else {
                lanternArray[item].colorType = 0
                lanternArray[item].life = 100
                stopLanternLifeDecrease(item: item)
                mixColors()
            }
        }
    }
    
    func stopLanternLifeDecrease(item: Int) {
        lanternArray[item].lifeTimer?.invalidate()
        lanternArray[item].lifeTimer = nil
        butterflyManager.removeButterflyForLantern(lanternIndex: item)
        removeButterfliesForAffectedLights(lanternIndex: item)
    }
    
    func updateLanternPosition() {
        for i in 0..<lanternArray.count {
            lanternArray[i].xPosition = lanternCoordinates[i].x
            lanternArray[i].yPosition = lanternCoordinates[i].y
        }
    }
    
    func updateLightsPosition() {
        for i in 0..<lightsArray.count {
            lightsArray[i].xPosition = lightCoordinates[i].x
            lightsArray[i].yPosition = lightCoordinates[i].y
        }
    }
    
    func lanternBlink() {
        withAnimation(Animation.easeInOut(duration: 0.6).repeatForever(autoreverses: true)) {
            lanternShadowRadius = 15
        }
    }
    
    func lanternImage(item: Int) -> String {
        return "lantern\(lanternArray[item].colorType)"
    }
    
    func lanternLight(item: Int) -> String {
        return "light\(lanternArray[item].colorType)"
    }
    
        func lightColor(item: Int) -> String {
        return "light\(lightsArray[item].colorType)"
    }
    
    func spawnButterflyForLantern(index: Int) {
        let lantern = lanternArray[index]
        guard lantern.colorType != 0 else { return }
        let lanternPosition = CGPoint(
            x: lantern.xPosition + screenWidth / 2,
            y: lantern.yPosition + screenHeight / 2
        )
        butterflyManager.spawnButterflyForLantern(
            colorType: lantern.colorType,
            lanternIndex: index,
            lanternPosition: lanternPosition
        )
    }
    
    func spawnButterfliesForLights() {
        for i in 0..<lightsArray.count {
            let light = lightsArray[i]
            guard light.colorType != 0 else { continue }
            let lightPosition = CGPoint(
                x: light.xPosition + screenWidth / 2,
                y: light.yPosition + screenHeight / 2
            )
            butterflyManager.spawnButterflyForLantern(
                colorType: light.colorType,
                lanternIndex: lanternArray.count + i,
                lanternPosition: lightPosition
            )
        }
    }
    
    func updateButterflyManagerPositions() {
        let lanternPositions = lanternArray.map { lantern in
            CGPoint(
                x: lantern.xPosition + screenWidth / 2,
                y: lantern.yPosition + screenHeight / 2
            )
        }
        let lightPositions = lightsArray.map { light in
            CGPoint(
                x: light.xPosition + screenWidth / 2,
                y: light.yPosition + screenHeight / 2
            )
        }
        butterflyManager.setLanternPositions(lanternPositions)
        butterflyManager.setLightPositions(lightPositions)
    }
    
    func updateButterflyForChangedLantern(index: Int) {
        butterflyManager.removeButterflyForLantern(lanternIndex: index)
        if lanternArray[index].colorType != 0 {
            spawnButterflyForLantern(index: index)
        }
    }
    
    func removeButterfliesForAffectedLights(lanternIndex: Int) {
        var affectedLightIndices: [Int] = []
        if lanternIndex < 6 {
            if lanternIndex < 5 {
                affectedLightIndices.append(lanternIndex)
            }
            if lanternIndex > 0 {
                affectedLightIndices.append(lanternIndex - 1)
            }
            let verticalLightIndex = 5 + lanternIndex
            if verticalLightIndex < 11 {
                affectedLightIndices.append(verticalLightIndex)
            }
        } else {
            let firstRowIndex = lanternIndex - 6
            let verticalLightIndex = 5 + firstRowIndex
            if verticalLightIndex < 11 {
                affectedLightIndices.append(verticalLightIndex)
            }
            if firstRowIndex < 5 {
                affectedLightIndices.append(11 + firstRowIndex)
            }
            if firstRowIndex > 0 {
                affectedLightIndices.append(11 + firstRowIndex - 1)
            }
        }
                for lightIndex in affectedLightIndices {
            let butterflyIndex = lanternArray.count + lightIndex
            butterflyManager.removeButterflyForLantern(lanternIndex: butterflyIndex)
        }
    }
    
    func catchButterfly(_ butterfly: FlyingButterfly) {
        for i in 0..<targetButtterfly.count {
            if targetButtterfly[i].type == butterfly.colorType {
                targetButtterfly[i].count += 1
                butterflyManager.removeButterflyById(butterfly.id)
                addCatchEffect(at: CGPoint(x: butterfly.xPosition, y: butterfly.yPosition))
                print("Поймана бабочка типа \(butterfly.colorType)! Всего: \(targetButtterfly[i].count)")
                break
            }
        }
    }
    
    func addCatchEffect(at position: CGPoint) {
        let effect = CatchEffect(position: position)
        catchEffects.append(effect)
        withAnimation(.easeOut(duration: 1.0)) {
             if let index = catchEffects.firstIndex(where: { $0.id == effect.id }) {
                 catchEffects[index].opacity = 0.0
                 catchEffects[index].scale = 2.0
             }
         }
         DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
             catchEffects.removeAll { $0.id == effect.id }
         }
     }
    
    func startGameTimer() {
        gameTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if elapsedTime > 0 {
                elapsedTime -= 1
            }
        }
    }
    
    func stopGameTimer() {
        gameTimer?.invalidate()
        gameTimer = nil
    }
}

#Preview {
    Game()
}
