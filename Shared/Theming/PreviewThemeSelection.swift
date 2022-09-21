//
//  PreferredThemeSelection.swift
//  Created by Marquis Kurt on 9/9/22.
//  This file is part of Gutenberg.
//
//  Gutenberg is non-violent software: you can use, redistribute, and/or modify it under the terms of the CNPLv7+ as
//  found in the LICENSE file in the source code root directory or at <https://git.pixie.town/thufie/npl-builder>.
//
//  Gutenberg comes with ABSOLUTELY NO WARRANTY, to the extent permitted by applicable law. See the CNPL for details.
//

import Foundation

/// An enumeration representing the various preview themes.
/// This is typically used in pickers to pick the theme to use in the preview pane.
enum PreviewThemeSelection: String, CaseIterable {
    /// The Manuscript theme. Uses monospace fonts and represents a manuscript.
    case manuscript = "Manuscript"

    /// The Bookworm theme. Uses serif fonts and represents a reader mode, like in Safari.
    case reader = "Bookworm"

    /// The Playful theme. Uses sans-serif fonts and represents a reader mode, like in Safari.
    case playful = "Playful"

    /// The preferred theme that the enumerations corresponds to.
    var theme: PreviewTheme {
        switch self {
        case .manuscript:
            return .manuscript
        case .reader:
            return .reader
        case .playful:
            return .playful
        }
    }
}
