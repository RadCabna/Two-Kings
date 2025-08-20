//
//  TestMoving.swift
//  Two Kings
//
//  Created by Алкександр Степанов on 14.08.2025.
//

import SwiftUI

struct PhysicsButterflyView: View {
    @State private var butterflyPosition = CGPoint(x: -100, y: -100)
    @State private var velocity = CGPoint(x: 0, y: 0)
    @State private var isVisible = false
    @State private var targetPosition = CGPoint(x: 200, y: 200)
    @State private var isOrbiting = false
    @State private var orbitCenter = CGPoint(x: 200, y: 200)
    @State private var butterflyRotation: Double = 0
    @State private var timer: Timer?
    
    var body: some View {
        ZStack {
            Color.clear
                .contentShape(Rectangle())
                .gesture(
                    DragGesture(minimumDistance: 0)
                        .onEnded { value in
                            handleTap(at: value.location)
                        }
                )
            
            Text("🦋")
                .font(.title)
                .position(butterflyPosition)
                .rotationEffect(.degrees(butterflyRotation))
                .opacity(isVisible ? 1.0 : 0.0)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .onAppear {
            startPhysicsLoop()
        }
        .onDisappear {
            stopPhysicsLoop()
        }
    }
    
    func handleTap(at location: CGPoint) {
        print("Нажатие в точке: x = \(Int(location.x)), y = \(Int(location.y))")
        
        if !isVisible {
            appearAndMoveTo(location)
        } else {
            changeTarget(to: location)
        }
    }
    
    func appearAndMoveTo(_ target: CGPoint) {
        print("Бабочка появляется и летит к точке: x = \(Int(target.x)), y = \(Int(target.y))")
        
        isVisible = true
        targetPosition = target
        orbitCenter = target
        
        // Вычисляем направление к цели
        let direction = CGPoint(
            x: target.x - butterflyPosition.x,
            y: target.y - butterflyPosition.y
        )
        
        let distance = sqrt(direction.x * direction.x + direction.y * direction.y)
        
        if distance > 0 {
            let normalizedDirection = CGPoint(
                x: direction.x / distance,
                y: direction.y / distance
            )
            
            // Задаем начальную скорость
            velocity = CGPoint(
                x: normalizedDirection.x * 3,
                y: normalizedDirection.y * 3
            )
        }
    }
    
    func changeTarget(to newTarget: CGPoint) {
        print("Меняем цель на: x = \(Int(newTarget.x)), y = \(Int(newTarget.y))")
        
        targetPosition = newTarget
        orbitCenter = newTarget
        isOrbiting = false
    }
    
    func startPhysicsLoop() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.016, repeats: true) { _ in
            updatePhysics()
        }
    }
    
    func stopPhysicsLoop() {
        timer?.invalidate()
        timer = nil
    }
    
    func updatePhysics() {
        guard isVisible else { return }
        
        let distanceToTarget = distanceTo(targetPosition)
        
        if distanceToTarget < 30 && !isOrbiting {
            print("Достигли цели, начинаем орбиту")
            startOrbiting()
        } else if distanceToTarget > 50 && isOrbiting {
            print("Далеко от цели, летим к ней")
            flyToTarget()
        } else if isOrbiting {
            orbitMovement()
        } else {
            directMovement()
        }
        
        // Обновляем позицию
        butterflyPosition.x += velocity.x
        butterflyPosition.y += velocity.y
        
        // Обновляем поворот
        updateRotation()
    }
    
    func directMovement() {
        let direction = directionTo(targetPosition)
        let speed: CGFloat = 2.0
        
        velocity.x = direction.x * speed
        velocity.y = direction.y * speed
    }
    
    func flyToTarget() {
        isOrbiting = false
        directMovement()
    }
    
    func startOrbiting() {
        isOrbiting = true
    }
    
    func orbitMovement() {
        let distance = distanceTo(orbitCenter)
        let radius: CGFloat = 50
        
        if distance > radius + 10 {
            // Слишком далеко - приближаемся
            let direction = directionTo(orbitCenter)
            velocity.x = direction.x * 1.5
            velocity.y = direction.y * 1.5
        } else if distance < radius - 10 {
            // Слишком близко - отдаляемся
            let direction = CGPoint(
                x: butterflyPosition.x - orbitCenter.x,
                y: butterflyPosition.y - orbitCenter.y
            )
            let normalized = normalize(direction)
            velocity.x = normalized.x * 1.5
            velocity.y = normalized.y * 1.5
        } else {
            // Орбитальное движение
            let tangentDirection = CGPoint(
                x: -(butterflyPosition.y - orbitCenter.y),
                y: butterflyPosition.x - orbitCenter.x
            )
            let normalizedTangent = normalize(tangentDirection)
            velocity.x = normalizedTangent.x * 2
            velocity.y = normalizedTangent.y * 2
        }
    }
    
    func updateRotation() {
        let angle = atan2(velocity.y, velocity.x) * 180 / .pi
        butterflyRotation = angle
    }
    
    func distanceTo(_ point: CGPoint) -> CGFloat {
        return sqrt(
            pow(butterflyPosition.x - point.x, 2) +
            pow(butterflyPosition.y - point.y, 2)
        )
    }
    
    func directionTo(_ point: CGPoint) -> CGPoint {
        let distance = distanceTo(point)
        if distance > 0 {
            return CGPoint(
                x: (point.x - butterflyPosition.x) / distance,
                y: (point.y - butterflyPosition.y) / distance
            )
        }
        return CGPoint(x: 0, y: 0)
    }
    
    func normalize(_ point: CGPoint) -> CGPoint {
        let length = sqrt(point.x * point.x + point.y * point.y)
        if length > 0 {
            return CGPoint(x: point.x / length, y: point.y / length)
        }
        return CGPoint(x: 0, y: 0)
    }
}

#Preview {
    PhysicsButterflyView()
}
