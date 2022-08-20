import SwiftUI

@available(iOS 15, macOS 12, *)
extension ProgressViewStyle where Self == RingProgressViewStyle<TintShapeStyle, Color> {
    public static var ring: some ProgressViewStyle { RingProgressViewStyle() }
}

@available(iOS, obsoleted: 15)
@available(macOS, obsoleted: 12)
extension ProgressViewStyle where Self == RingProgressViewStyle<Color, Color> {
    @available(iOS, obsoleted: 15)
    @available(macOS, obsoleted: 12)
    public static var ring: some ProgressViewStyle { RingProgressViewStyle() }
}
