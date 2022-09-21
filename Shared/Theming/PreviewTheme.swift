//
//  PreferredTheme.swift
//  Created by Marquis Kurt on 9/9/22.
//  This file is part of Gutenberg.
//
//  Gutenberg is non-violent software: you can use, redistribute, and/or modify it under the terms of the CNPLv7+ as
//  found in the LICENSE file in the source code root directory or at <https://git.pixie.town/thufie/npl-builder>.
//
//  Gutenberg comes with ABSOLUTELY NO WARRANTY, to the extent permitted by applicable law. See the CNPL for details.
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
