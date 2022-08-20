import SwiftUI

public struct RingProgressViewStyle<Foreground: ShapeStyle, Background: ShapeStyle> {
    private let foregroundStyle: Foreground
    private let backgroundStyle: Background
    private let strokeStyle: StrokeStyle

    @available(iOS 15, macOS 12, *)
    public init(stroke: StrokeStyle = .init(lineWidth: 4.0, lineCap: .round))
    where
        Foreground == TintShapeStyle,
        Background == Color
    {
        self.foregroundStyle = .tint
        self.backgroundStyle = Color.secondary.opacity(0.2)
        self.strokeStyle = stroke
    }

    @available(iOS, obsoleted: 15)
    @available(macOS, obsoleted: 12)
    public init(stroke: StrokeStyle = .init(lineWidth: 4.0, lineCap: .round))
    where
        Foreground == Color,
        Background == Color
    {
        self.foregroundStyle = .accentColor
        self.backgroundStyle = Color.secondary.opacity(0.2)
        self.strokeStyle = stroke
    }

    public init(
        foreground: Foreground,
        stroke: StrokeStyle = .init(lineWidth: 4.0, lineCap: .round)
    ) where Background == Color {
        self.foregroundStyle = foreground
        self.backgroundStyle = Color.secondary.opacity(0.2)
        self.strokeStyle = stroke
    }

    @available(iOS 15, macOS 12, *)
    public init(
        background: Background,
        stroke: StrokeStyle = .init(lineWidth: 4.0, lineCap: .round)
    ) where Foreground == TintShapeStyle {
        self.foregroundStyle = .tint
        self.backgroundStyle = background
        self.strokeStyle = stroke
    }

    @available(iOS, obsoleted: 15)
    @available(macOS, obsoleted: 12)
    public init(
        background: Background,
        stroke: StrokeStyle = .init(lineWidth: 4.0, lineCap: .round)
    ) where Foreground == Color {
        self.foregroundStyle = .accentColor
        self.backgroundStyle = background
        self.strokeStyle = stroke
    }

    public init(
        foreground: Foreground,
        background: Background,
        stroke: StrokeStyle = .init(lineWidth: 4.0, lineCap: .round)
    ) {
        self.foregroundStyle = foreground
        self.backgroundStyle = background
        self.strokeStyle = stroke
    }
}

extension RingProgressViewStyle: ProgressViewStyle {
    public func makeBody(configuration: Self.Configuration) -> some View {
        HStack {
            self.ring(value: configuration.fractionCompleted ?? 0)
            if configuration.label != nil || configuration.currentValueLabel != nil {
                self.label(configuration: configuration)
            }
        }
    }

    private var backgroundCircle: some View {
        Circle().strokeBorder(self.backgroundStyle, style: self.strokeStyle)
    }

    private func ring(value: Double) -> some View {
        InsetArc(endAngle: .degrees(value * 360))
            .strokeBorder(self.foregroundStyle, style: self.strokeStyle)
            .rotationEffect(.degrees(-90))
            .opacity(value > 0 ? 1 : 0.5)
            .background(self.backgroundCircle)
            .scaledToFit()
    }

    private func label(configuration: Self.Configuration) -> some View {
        VStack(alignment: .leading, spacing: 5) {
            if let label = configuration.label {
                label
            }
            if let label = configuration.currentValueLabel {
                label
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
    }
}

struct ProgressRing_Previews: PreviewProvider {
    private struct PreviewView: View {
        @State private var progress = 0.0

        private func increment() async throws {
            if self.progress >= 1 {
                self.progress = 0
            }
            try await Task.sleep(nanoseconds: 1 * 1000000000)
            self.progress += 0.1
            try await self.increment()
        }

        var body: some View {
            if #available(iOS 15, macOS 12, *) {
                self.mainBody
                    .task { try? await self.increment() }
            } else {
                self.mainBody
                    .onAppear { Task { try? await self.increment() } }
            }
        }

        private var mainBody: some View {
            VStack(spacing: 20) {
                ProgressView(value: self.progress)
                    .frame(width: 200)
                    .animation(.default, value: self.progress)

                ProgressView(value: self.progress)
                    .progressViewStyle(.ring)
                    .frame(width: 60)
                    .animation(.default, value: self.progress)

                let progressViewWithLabel = ProgressView(value: self.progress, total: 1.0) {
                    Text("Downloading...")
                } currentValueLabel: {
                    if #available(iOS 15, macOS 12, *) {
                        Text(self.progress, format: .percent)
                    } else {
                        Text("\(self.progress * 100, specifier: "%.1f")") + Text("%")
                    }
                }
                .frame(width: 200)
                .animation(.default, value: self.progress)
                if #available(iOS 15, macOS 12, *) {
                    progressViewWithLabel.tint(.purple)
                } else {
                    progressViewWithLabel.accentColor(.purple)
                }

                let ringProgressViewWithLabel = ProgressView(value: self.progress, total: 1.0) {
                    Text("Downloading...")
                } currentValueLabel: {
                    if #available(iOS 15, macOS 12, *) {
                        Text(self.progress, format: .percent)
                    } else {
                        Text("\(self.progress * 100, specifier: "%.1f")") + Text("%")
                    }
                }
                .progressViewStyle(.ring)
                .frame(height: 60)
                .animation(.default, value: self.progress)
                if #available(iOS 15, macOS 12, *) {
                    ringProgressViewWithLabel.tint(.purple)
                } else {
                    ringProgressViewWithLabel.accentColor(.purple)
                }

                ProgressView(value: self.progress)
                    .progressViewStyle(
                        RingProgressViewStyle(
                            foreground: .green,
                            background: .red,
                            stroke: .init(lineWidth: 5, lineCap: .butt)
                        )
                    )
                    .frame(width: 80, height: 80)
                    .animation(.default, value: self.progress)

                ProgressView(value: self.progress)
                    .progressViewStyle(
                        RingProgressViewStyle(
                            foreground: .angularGradient(
                                .init(
                                    colors: [
                                        Color(red: 200 / 255, green: 168 / 255, blue: 240 / 255),
                                        Color(red: 71 / 255, green: 33 / 255, blue: 158 / 255)
                                    ]
                                ),
                                center: .center,
                                startAngle: .zero,
                                endAngle: .degrees(self.progress * 360)
                            ),
                            stroke: .init(lineWidth: 20, lineCap: .round)
                        )
                    )
                    .frame(width: 100, height: 100)
                    .animation(.default, value: self.progress)
            }
        }
    }

    static var previews: some View {
        PreviewView()
    }
}
