//
//  PieDiagram.swift
//  quickpoll
//
//  Created by Sandro Darnuzer on 05.09.22.
//

import SwiftUI

struct Slice: Shape {
    
    let center: CGPoint
    let radius: CGFloat
    let startAngle: Angle
    let endAngle: Angle
    let clockWise: Bool
    
    func path(in rect: CGRect) -> Path {
        return Path { path in
            path.move(to: center)
            path.addArc(
                center: center,
                radius: radius,
                startAngle: startAngle - Angle.degrees(90),
                endAngle: endAngle - Angle.degrees(90),
                clockwise: !clockWise
            )
            path.closeSubpath()
        }
    }
}

struct AngleSet: Hashable {
    let startAngle: Angle
    let endAngle: Angle
}

struct PieDiagram: View {
    
    
    private let colorManager = ColorManager.instance
    private var angles: [AngleSet] = []
    
    init(values: [Double]) {
        self.angles = calculateAngles(values: values)
    }
    
    private func calculateAngles(values: [Double]) -> [AngleSet] {
        let total = values.reduce(0) { currentTotal, value in
            return currentTotal + value
        }
        
        var angleSet: [AngleSet] = []
        var previousAngle: Angle = .degrees(0)
        
        for value in values {
        
            let degree = 360 / total * value // 180
            let currentAngle = Angle.degrees(degree) + previousAngle
            angleSet.append(AngleSet(startAngle: previousAngle, endAngle: currentAngle))
            
            previousAngle = currentAngle
        }
        
        return angleSet
    }
    
    var body: some View {
        
        GeometryReader { proxy in
            ZStack {
                ForEach(angles, id: \.self) { angle in
                    Slice(
                        center: CGPoint(x: proxy.size.width / 2, y: proxy.size.height / 2),
                        radius: proxy.size.width / 2,
                        startAngle: angle.startAngle,
                        endAngle: angle.endAngle,
                        clockWise: true
                    )
                    .fill(colorManager.getColor())
                }
            
            }
        }
        
    }
}

class ColorManager {
    static let instance = ColorManager()
    
    private var index = 0
    private var colors = [
        Color.blue,
        Color.red,
        Color.green,
    ]
    
    func getColor() -> Color {
        let color = colors[index]
        index += 1
        if index >= colors.count {
            index = 0
        }
        return color
    }
}

struct PieDiagram_Previews: PreviewProvider {
    static var previews: some View {
        PieDiagram(values: [
            1, 1 ,1
        ])
    }
}
