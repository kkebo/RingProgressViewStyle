import SwiftUI

struct InsetArc {
    private let startAngle: Angle
    private var endAngle: Angle
    private var insetAmount = 0.0

    init(startAngle: Angle = .zero, endAngle: Angle) {
        self.startAngle = startAngle
        self.endAngle = endAngle
    }
}

extension InsetArc: Animatable {
    var animatableData: CGFloat {
        get { self.endAngle.degrees }
        set { self.endAngle = .degrees(newValue) }
    }
}

extension InsetArc: Shape {
    func path(in rect: CGRect) -> Path {
        .init { path in
            path.addArc(
                center: .init(x: rect.width / 2, y: rect.height / 2),
                radius: min(rect.width, rect.height) / 2 - self.insetAmount,
                startAngle: self.startAngle,
                endAngle: self.endAngle,
                clockwise: false
            )
        }
    }
}

extension InsetArc: InsettableShape {
    func inset(by amount: CGFloat) -> Self {
        var arc = self
        arc.insetAmount += amount
        return arc
    }
}
