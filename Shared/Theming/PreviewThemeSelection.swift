//
//  PreferredThemeSelection.swift
//  Gutenberg
//
//  Created by Marquis Kurt on 9/9/22.
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
