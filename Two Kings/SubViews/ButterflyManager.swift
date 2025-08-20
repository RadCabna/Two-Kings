import SwiftUI

public class ButterflyManager: ObservableObject {
    @Published var flyingButterflies: [FlyingButterfly] = []
    private var updateTimer: Timer?
    private let screenBounds = UIScreen.main.bounds
    private let maxButterflies = 12
    
    init() {
        startUpdateTimer()
    }
    
    deinit {
        stopUpdateTimer()
    }
    
    func startUpdateTimer() {
        updateTimer = Timer.scheduledTimer(withTimeInterval: 0.016, repeats: true) { _ in
            self.updateButterflies()
        }
    }
    
    func stopUpdateTimer() {
        updateTimer?.invalidate()
        updateTimer = nil
    }
    
    func spawnButterflyForLantern(colorType: Int, lanternIndex: Int, lanternPosition: CGPoint) {
        if flyingButterflies.count >= maxButterflies {
            return
        }
        let existingButterfly = flyingButterflies.first { 
            $0.targetLanternIndex == lanternIndex && $0.currentPhase != .leaving 
        }
        if existingButterfly != nil {
            return
        }
        let delay = Double.random(in: 0.5...2.0)
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            self.createButterflyForLantern(colorType: colorType, lanternIndex: lanternIndex, lanternPosition: lanternPosition)
        }
    }
    
    private func createButterflyForLantern(colorType: Int, lanternIndex: Int, lanternPosition: CGPoint) {
        let spawnPosition = getRandomSpawnPosition()
        var butterfly = FlyingButterfly(
            colorType: colorType,
            xPosition: spawnPosition.x,
            yPosition: spawnPosition.y,
            targetLanternIndex: lanternIndex,
            speed: CGFloat.random(in: 1.5...3.0)
        )
        flyingButterflies.append(butterfly)
    }
    
    func removeButterflyForLantern(lanternIndex: Int) {
        for i in 0..<flyingButterflies.count {
            if flyingButterflies[i].targetLanternIndex == lanternIndex {
                flyingButterflies[i].currentPhase = .leaving
                withAnimation(.easeOut(duration: 0.5)) {
                    flyingButterflies[i].isVisible = false
                }
            }
        }
    }
    
    private func updateButterflies() {
        for i in stride(from: flyingButterflies.count - 1, through: 0, by: -1) {
            updateButterfly(at: i)
        }
    }
    
    private func updateButterfly(at index: Int) {
        guard index < flyingButterflies.count else { return }
        
        switch flyingButterflies[index].currentPhase {
        case .flying:
            updateFlyingPhase(at: index)
        case .orbiting:
            updateOrbitingPhase(at: index)
        case .leaving:
            updateLeavingPhase(at: index)
        }
    }
    
    private func updateFlyingPhase(at index: Int) {
        let butterfly = flyingButterflies[index]
        let targetPosition = getLanternPosition(for: butterfly.targetLanternIndex)
        let deltaX = targetPosition.x - butterfly.xPosition
        let deltaY = targetPosition.y - butterfly.yPosition
        let distance = sqrt(deltaX * deltaX + deltaY * deltaY)
        if distance < 80 {
            flyingButterflies[index].currentPhase = .orbiting
            flyingButterflies[index].angle = Double.random(in: 0...2*Double.pi)
            return
        }
        let time = Date().timeIntervalSince1970
        let uniqueOffset = Double(butterfly.id.hashValue % 1000) / 1000.0
        let wiggleX = sin(time * 3 + uniqueOffset * 2 * Double.pi) * 10
        let wiggleY = cos(time * 2.5 + uniqueOffset * 2 * Double.pi) * 8
        let normalizedX = deltaX / distance
        let normalizedY = deltaY / distance
        let moveX = (normalizedX * butterfly.speed) + wiggleX * 0.2
        let moveY = (normalizedY * butterfly.speed) + wiggleY * 0.2
        flyingButterflies[index].movementDirection = atan2(moveY, moveX)
        flyingButterflies[index].xPosition += moveX
        flyingButterflies[index].yPosition += moveY
    }
    
    private func updateOrbitingPhase(at index: Int) {
        let butterfly = flyingButterflies[index]
        let targetPosition = getLanternPosition(for: butterfly.targetLanternIndex)
        let rotationSpeed = 0.03 + (butterfly.speed - 2.0) * 0.01
        flyingButterflies[index].angle += rotationSpeed
        let time = Date().timeIntervalSince1970
        let radiusVariation = sin(time * 2 + butterfly.angle) * 15
        let currentRadius = butterfly.orbitRadius + radiusVariation
        let newX = targetPosition.x + cos(butterfly.angle) * currentRadius
        let newY = targetPosition.y + sin(butterfly.angle) * currentRadius
        flyingButterflies[index].movementDirection = butterfly.angle + .pi / 2
        flyingButterflies[index].xPosition = newX
        flyingButterflies[index].yPosition = newY
    }
    
    private func updateLeavingPhase(at index: Int) {
        let butterfly = flyingButterflies[index]
        let directions = [
            CGPoint(x: -1, y: 0),
            CGPoint(x: 1, y: 0),
            CGPoint(x: 0, y: -1),
            CGPoint(x: 0, y: 1)
        ]
        let direction = directions.randomElement() ?? CGPoint(x: -1, y: 0)
        flyingButterflies[index].movementDirection = atan2(direction.y, direction.x)
        flyingButterflies[index].xPosition += direction.x * butterfly.speed * 2
        flyingButterflies[index].yPosition += direction.y * butterfly.speed * 2
        if butterfly.xPosition < -100 || butterfly.xPosition > screenBounds.width + 100 ||
           butterfly.yPosition < -100 || butterfly.yPosition > screenBounds.height + 100 {
            flyingButterflies.remove(at: index)
        }
    }
    
    private func getRandomSpawnPosition() -> CGPoint {
        let side = Int.random(in: 0...3)
        switch side {
        case 0:
            return CGPoint(x: -50, y: CGFloat.random(in: 0...screenBounds.height))
        case 1:
            return CGPoint(x: screenBounds.width + 50, y: CGFloat.random(in: 0...screenBounds.height))
        case 2:
            return CGPoint(x: CGFloat.random(in: 0...screenBounds.width), y: -50)
        default:
            return CGPoint(x: CGFloat.random(in: 0...screenBounds.width), y: screenBounds.height + 50)
        }
    }
    
    private func getLanternPosition(for index: Int) -> CGPoint {
        if index < lanternPositions.count {
            return lanternPositions[index]
        } else {
            let lightIndex = index - lanternPositions.count
            if lightIndex < lightPositions.count {
                return lightPositions[lightIndex]
            }
        }
        let coordinates = Arrays.lanternCoordinates
        if index < coordinates.count {
            return CGPoint(
                x: coordinates[index].x + screenBounds.width / 2,
                y: coordinates[index].y + screenBounds.height / 2
            )
        }
        return CGPoint(x: screenBounds.width / 2, y: screenBounds.height / 2)
    }
    
    private var lanternPositions: [CGPoint] = []
    private var lightPositions: [CGPoint] = []
    
    func setLanternPositions(_ positions: [CGPoint]) {
        self.lanternPositions = positions
    }
    
    func setLightPositions(_ positions: [CGPoint]) {
        self.lightPositions = positions
    }
    
    func removeAllButterflies() {
        for i in 0..<flyingButterflies.count {
            flyingButterflies[i].currentPhase = .leaving
            withAnimation(.easeOut(duration: 0.3)) {
                flyingButterflies[i].isVisible = false
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.flyingButterflies.removeAll()
        }
    }
    
    func removeButterflyById(_ butterflyId: UUID) {
        if let index = flyingButterflies.firstIndex(where: { $0.id == butterflyId }) {
            flyingButterflies[index].currentPhase = .leaving
            withAnimation(.easeOut(duration: 0.3)) {
                flyingButterflies[index].isVisible = false
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.flyingButterflies.removeAll { $0.id == butterflyId }
            }
        }
    }
    
    func validateButterfliesTargets(lanterns: [Lantern], lights: [Light]) {
        var butterfliesToRemove: [Int] = []
        for i in 0..<flyingButterflies.count {
            let butterfly = flyingButterflies[i]
            let targetIndex = butterfly.targetLanternIndex
            var shouldRemove = false
            if targetIndex < lanterns.count {
                if lanterns[targetIndex].colorType == 0 {
                    shouldRemove = true
                }
            } else {
                let lightIndex = targetIndex - lanterns.count
                if lightIndex < lights.count && lights[lightIndex].colorType == 0 {
                    shouldRemove = true
                }
            }
            if shouldRemove {
                butterfliesToRemove.append(i)
            }
        }
        for index in butterfliesToRemove.reversed() {
            flyingButterflies[index].currentPhase = .leaving
            withAnimation(.easeOut(duration: 0.3)) {
                flyingButterflies[index].isVisible = false
            }
        }
    }
} 