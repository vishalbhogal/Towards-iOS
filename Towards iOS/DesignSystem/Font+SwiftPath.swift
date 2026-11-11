//
//  Font+SwiftPath.swift
//  SwiftPath design system: typography
//
//  Every style uses Font.custom(_:size:relativeTo:) so it scales with Dynamic Type.
//  The strings are PostScript names, not file names.
//

import SwiftUI

enum FontName {
    static let anton = "Anton-Regular"
    static let interRegular = "InterTight-Regular"
    static let interMedium = "InterTight-Medium"
    static let interSemiBold = "InterTight-SemiBold"
    static let interBold = "InterTight-Bold"
    static let monoRegular = "JetBrainsMono-Regular"
    static let monoMedium = "JetBrainsMono-Medium"
}

extension Font {
    // MARK: Anton (uppercase headlines only, never paragraphs)

    /// Anton 60, uppercase. "FOUNDATIONS" on the Learn screen.
    static let spDisplay = Font.custom(FontName.anton, size: 60, relativeTo: .largeTitle)

    /// Anton 34. Title on the black feature card.
    static let spCardTitle = Font.custom(FontName.anton, size: 34, relativeTo: .title)

    /// Anton 26, uppercase. Section headings.
    static let spSection = Font.custom(FontName.anton, size: 26, relativeTo: .title2)

    /// Anton 28. Lesson numbers in the list (01, 02...).
    static let spRowNumber = Font.custom(FontName.anton, size: 28, relativeTo: .title2)

    // MARK: Inter Tight (all UI text)

    /// Inter Tight SemiBold 17. Row titles.
    static let spHeadline = Font.custom(FontName.interSemiBold, size: 17, relativeTo: .headline)

    /// Inter Tight Regular 17. Body copy (line height 27, see spBodyLineSpacing).
    static let spBody = Font.custom(FontName.interRegular, size: 17, relativeTo: .body)

    /// Inter Tight Bold 16. Pill button labels.
    static let spButton = Font.custom(FontName.interBold, size: 16, relativeTo: .headline)

    /// Inter Tight Regular 15. Secondary row text and meta.
    static let spSubhead = Font.custom(FontName.interRegular, size: 15, relativeTo: .subheadline)

    /// Inter Tight Bold 13, uppercase, tracking 8%. Eyebrows and labels.
    static let spLabel = Font.custom(FontName.interBold, size: 13, relativeTo: .footnote)

    // MARK: JetBrains Mono (code)

    /// JetBrains Mono 13 (line height 20). Code blocks.
    static let spCode = Font.custom(FontName.monoRegular, size: 13, relativeTo: .footnote)
}

/// Extra spacing to reach the spec's line heights (line height minus font size).
enum SPLineSpacing {
    static let body: CGFloat = 10   // 17/27
    static let code: CGFloat = 7    // 13/20
}

extension View {
    /// Uppercase label with 8% tracking, as in the style guide.
    func spLabelStyle() -> some View {
        self.font(.spLabel)
            .textCase(.uppercase)
            .tracking(13 * 0.08)
    }
}

#if DEBUG
/// Call once (for example in the App init) to check the fonts are registered.
/// If a name is missing, the font is not in "Fonts provided by application"
/// or the file is not in the app target.
enum FontCheck {
    static func printMissing() {
        let names = [FontName.anton, FontName.interRegular, FontName.interMedium,
                     FontName.interSemiBold, FontName.interBold,
                     FontName.monoRegular, FontName.monoMedium]
        for name in names where UIFont(name: name, size: 12) == nil {
            print("⚠️ Font not found: \(name)")
        }
    }
}
#endif

#Preview("Type scale") {
    ScrollView {
        VStack(alignment: .leading, spacing: 16) {
            Text("Foundations").font(.spDisplay).textCase(.uppercase)
            Text("Up next").spLabelStyle().foregroundStyle(.signal)
            Text("State and Binding").font(.spCardTitle).textCase(.uppercase)
            Text("Section").font(.spSection).textCase(.uppercase)
            Text("Row title").font(.spHeadline)
            Text("Body copy explains the idea in plain words, at 17 on 27.")
                .font(.spBody).lineSpacing(SPLineSpacing.body)
            Text("Start lesson").font(.spButton)
            Text("@State var isLit = false").font(.spCode)
        }
        .foregroundStyle(.ink)
        .padding(20)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    .background(.paper)
}
