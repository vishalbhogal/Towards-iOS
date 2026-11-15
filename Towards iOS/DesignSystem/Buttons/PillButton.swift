//
//  PillButton.swift
//  Towards iOS
//
//  Created by Vishal Bhogal on 12/11/26.
//

import SwiftUI

/// Primary call to action: ink capsule, paper label, 56pt tall, full width.
/// Matches "03 Style guide and specs" › Components.
struct PillButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(Font.spButton)
            .foregroundStyle(Color.paper)
            .padding(.horizontal, 32)
            .frame(maxWidth: .infinity, minHeight: 56)
            .background(Color.ink, in: .capsule)
            .contentShape(.capsule)
            .scaleEffect(configuration.isPressed ? 0.97 : 1)
            .animation(.snappy, value: configuration.isPressed)
    }
}

/// Circular 44pt icon button on the `fill` color (back, bookmark, close).
/// Give the Button an accessibilityLabel, since it has no visible text.
struct IconButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.system(size: 18, weight: .semibold))
            .foregroundStyle(Color.ink)
            .frame(width: 44, height: 44)
            .background(Color.fill, in: .circle)
            .contentShape(.circle)
            .scaleEffect(configuration.isPressed ? 0.97 : 1)
            .animation(.snappy, value: configuration.isPressed)
    }
}

extension ButtonStyle where Self == PillButtonStyle {
    /// `.buttonStyle(.pill)`
    static var pill: PillButtonStyle { PillButtonStyle() }
}

extension ButtonStyle where Self == IconButtonStyle {
    /// `.buttonStyle(.icon)`
    static var icon: IconButtonStyle { IconButtonStyle() }
}

#Preview("Pill") {
    Button("Mark complete") { }
        .buttonStyle(.pill)
        .padding(20)
}

#Preview("Icon") {
    HStack(spacing: 12) {
        Button { } label: { Image(systemName: "chevron.left") }
            .buttonStyle(.icon)
            .accessibilityLabel("Back to all lessons")
        Button { } label: { Image(systemName: "bookmark") }
            .buttonStyle(.icon)
            .accessibilityLabel("Bookmark lesson")
    }
    .padding(20)
}
