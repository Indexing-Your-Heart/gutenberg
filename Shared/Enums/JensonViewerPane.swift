//
//  JensonViewerPane.swift
//  Gutenberg
//
//  Created by Marquis Kurt on 9/9/22.
//

import Foundation

/// An enumeration representing the various panes.
enum JensonViewerPane: String, CaseIterable {
    /// The source view, which shows the internal JSON.
    case source = "Source View"

    /// The formatted view.
    case preview = "Preview"

    /// The system image name associated with the pane.
    var systemImage: String {
        switch self {
        case .preview:
            return "eye"
        case .source:
            return "curlybraces.square"
        }
    }
}
