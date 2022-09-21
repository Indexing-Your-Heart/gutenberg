//
//  PreferredTheme.swift
//  Gutenberg
//
//  Created by Marquis Kurt on 9/9/22.
//

import SwiftUI

/// A struct that represents a preview theme.
struct PreviewTheme {
    /// The font style to use in the preview.
    var fontStyle: Font

    /// The background color of the preview.
    var backgroundColor: Color?

    /// The foreground color of the preview.
    var textColor: Color

    /// A theme representing the Manuscript theme.
    static let manuscript = PreviewTheme(
        fontStyle: .custom("iA Writer Mono V", size: 13, relativeTo: .body),
        backgroundColor: nil,
        textColor: .primary
    )

    /// A theme representing the Bookworm theme.
    static let reader = PreviewTheme(
        fontStyle: .custom("Crimson Text", size: 15, relativeTo: .body),
        backgroundColor: .init("ReaderBackground"),
        textColor: .init("ReaderPrimary")
    )

    /// A theme representing the Playful theme.
    static let playful = PreviewTheme(
        fontStyle: .system(.body, design: .rounded),
        backgroundColor: nil,
        textColor: .primary
    )
}
