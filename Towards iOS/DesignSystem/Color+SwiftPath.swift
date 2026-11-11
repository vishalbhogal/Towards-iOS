//
//  Color+SwiftPath.swift
//  SwiftPath design system: colors
//
//  The six colors live in Assets.xcassets (ink, paper, signal, fill, line, muted).
//
//  Xcode 15+ already generates `Color.ink`, `.ink` etc. from the asset catalog
//  ("Generate Swift Asset Symbol Extensions" = Yes, the default). So you do NOT
//  write `static let ink = Color("ink")` yourself: that would clash with the
//  generated symbol. This file only adds the semantic names the screens use.
//
//  Gotcha: SwiftUI already has a `.fill` shape style (FillShapeStyle), so the
//  short form `.fill` can mean the system one. Write `Color.fill` to be safe.
//

import SwiftUI

extension Color {
    /// Small red text on white (5:1 contrast). Use signal only for fills,
    /// type 24pt and up, or anything on ink.
    static let signalText = Color(red: 0xC6 / 255, green: 0x2A / 255, blue: 0x12 / 255)
}

extension ShapeStyle where Self == Color {
    static var signalText: Color { Color.signalText }
}

#Preview("Palette") {
    let swatches: [(String, Color)] = [
        ("ink", Color.ink), ("paper", Color.paper), ("signal", Color.signal),
        ("fill", Color.fill), ("line", Color.line), ("muted", Color.muted),
    ]
    return List(swatches, id: \.0) { name, color in
        HStack(spacing: 16) {
            RoundedRectangle(cornerRadius: 12)
                .fill(color)
                .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.line))
                .frame(width: 56, height: 40)
            Text(name).font(.headline)
        }
    }
}
