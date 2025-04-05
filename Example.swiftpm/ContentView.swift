import RingProgressViewStyle
import SwiftUI

struct ContentView {
    @State private var progress = 0.0

    private func increment() async throws {
        if self.progress >= 1 {
            self.progress = 0
        }
        try await Task.sleep(nanoseconds: 1 * 1_000_000_000)
        self.progress += 0.1
        try await self.increment()
    }
}

extension ContentView: View {
    var body: some View {
        VStack(spacing: 20) {
            ProgressView(value: self.progress)
                .frame(width: 200)
                .animation(.default, value: self.progress)

            ProgressView(value: self.progress)
                .progressViewStyle(.ring)
                .frame(width: 60)
                .animation(.default, value: self.progress)

            ProgressView(value: self.progress, total: 1.0) {
                Text("Downloading...")
            } currentValueLabel: {
                Text(self.progress, format: .percent)
            }
            .frame(width: 200)
            .tint(.purple)
            .animation(.default, value: self.progress)

            ProgressView(value: self.progress, total: 1.0) {
                Text("Downloading...")
            } currentValueLabel: {
                Text(self.progress, format: .percent)
            }
            .progressViewStyle(.ring)
            .frame(height: 60)
            .tint(.purple)
            .animation(.default, value: self.progress)

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
                                    Color(red: 71 / 255, green: 33 / 255, blue: 158 / 255),
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
        .task { try? await self.increment() }
    }
}
