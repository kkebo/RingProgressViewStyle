import SwiftUI

@available(iOS 15, macOS 12, *)
extension ProgressViewStyle where Self == RingProgressViewStyle<TintShapeStyle, Color> {
    /// A progress view that visually indicates its progress using a ring.
    public static var ring: Self { .init() }
}

@available(iOS, obsoleted: 15)
@available(macOS, obsoleted: 12)
extension ProgressViewStyle where Self == RingProgressViewStyle<Color, Color> {
    /// A progress view that visually indicates its progress using a ring.
    @available(iOS, obsoleted: 15)
    @available(macOS, obsoleted: 12)
    public static var ring: Self { .init() }
}
